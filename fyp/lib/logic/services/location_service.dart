import 'dart:async';
import 'dart:io'; // For InternetAddress lookup
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/settings/android_settings.dart'
    as bg_locator_android_settings; // Alias for background_locator_2
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/data/models/other/location_model.dart';
import 'package:fyp/data/repositories/visitor_repository.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocationService {
  static Future<void> initLocationService() async {
    try {
      print('Initializing location service...');
      final dir = await getApplicationDocumentsDirectory();
      print('Application documents directory: ${dir.path}');
      Hive.init(dir.path);

      await BackgroundLocator.registerLocationUpdate(
        LocationCallbackHandler.callback,
        autoStop: false,
        androidSettings: const bg_locator_android_settings.AndroidSettings(
          accuracy: LocationAccuracy.HIGH,
          interval: 5000,
          distanceFilter: 0,
          client: bg_locator_android_settings.LocationClient.google,
          androidNotificationSettings:
              bg_locator_android_settings.AndroidNotificationSettings(
            notificationChannelName: 'Location Tracking',
            notificationTitle: 'Tracking your location',
            notificationMsg: 'Your location is being tracked',
            notificationBigMsg:
                'Your location is being tracked in the background',
            notificationIcon:
                'icon', // Ensure this icon is available in your drawable folder
            notificationTapCallback:
                LocationCallbackHandler.notificationCallback,
          ),
        ),
        iosSettings: const IOSSettings(
          accuracy: LocationAccuracy.HIGH,
          distanceFilter: 0,
        ),
      );
      print('Location service initialized successfully');
    } catch (e) {
      print('Failed to initialize location service: $e');
    }
  }

  static Future<void> stopLocationService() async {
    try {
      print('Stopping location service...');
      await BackgroundLocator.unRegisterLocationUpdate();
      print('Location service stopped successfully');
    } catch (e) {
      print('Failed to stop location service: $e');
    }
  }
}

class LocationCallbackHandler {
  static Future<void> callback(LocationDto locationDto) async {
    try {
      print('Location callback triggered with data: $locationDto');
      final box = await Hive.openBox<LocationModel>('locationBox');
      print('Opened Hive box: ${box.name}');

      final appointments = await getAppointmentsWithStatusEntered();
      print('Fetched ${appointments.length} appointments');

      for (final appointment in appointments) {
        final location = LocationModel(
          latitude: locationDto.latitude,
          longitude: locationDto.longitude,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          appointmentId: appointment.id,
        );
        print('Adding location to box: $location');
        box.add(location);
      }

      if (await hasInternetConnection()) {
        print('Internet connection available');
        final locations = box.values.toList();
        for (final location in locations) {
          await sendLocationToServer(location);
          location.delete();
          print('Location sent to server and deleted from box');
        }
      } else {
        print('No internet connection available');
      }
    } catch (e) {
      print('Error in location callback: $e');
    }
  }

  static Future<void> notificationCallback() async {
    print('Notification callback triggered');
  }

  static Future<void> sendLocationToServer(LocationModel location) async {
    try {
      print('Sending location to server: $location');
      final VisitorRepository _visitorRepository = VisitorRepository();
      await _visitorRepository.sendAppointmentLocation(
        appointmentId: location.appointmentId,
        latitude: location.latitude,
        longitude: location.longitude,
        timestamp: location.timestamp,
        status: 'running',
      );
      print('Location sent successfully: $location');
    } catch (e) {
      print('Failed to send location: $e');
    }
  }

  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      bool isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      print('Internet connection check: $isConnected');
      return isConnected;
    } catch (_) {
      print('Internet connection check failed');
      return false;
    }
  }

  static Future<List<AppointmentDataModel>>
      getAppointmentsWithStatusEntered() async {
    try {
      print(
          'Fetching appointments with status "entered", "running", or "redListed"');
      final visitorCubit = VisitorCubitSingleton.getInstance();
      await visitorCubit.fetchAppointments();
      final state = visitorCubit.state;

      if (state is VisitorAppointmentFetchLoadedState) {
        print('Appointments fetched successfully');
        return state.appointmentData.where((appointment) {
          return appointment.status == 'entered' ||
              appointment.status == 'running' ||
              appointment.status == 'redListed';
        }).toList();
      } else {
        print('Failed to fetch appointments or no appointments found');
        return [];
      }
    } catch (e) {
      print('Error fetching appointments: $e');
      return [];
    }
  }
}

class VisitorCubitSingleton {
  static final VisitorCubit _visitorCubit = VisitorCubit();

  static VisitorCubit getInstance() => _visitorCubit;
}
