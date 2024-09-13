import 'dart:async';
import 'dart:io';
import 'package:location/location.dart';
import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/data/models/other/location_model.dart';
import 'package:fyp/data/repositories/visitor_repository.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocationService {
  static Location location = Location();
  static StreamSubscription<LocationData>? _locationSubscription;
  static List<AppointmentDataModel> _appointments = [];

  static Future<void> initLocationService() async {
    try {
      print('Initializing location service...');
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      // Check if location service is enabled
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          print('Location service is disabled');
          return;
        }
      }

      // Check for location permission
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location permission denied');
          return;
        }
      }

      // Enable background mode for location
      bool backgroundMode = await location.enableBackgroundMode(enable: true);
      print('Background mode enabled: $backgroundMode');

      // Fetch appointments once
      await _fetchAppointments();

      // Configure the location settings
      location.changeSettings(
        accuracy: LocationAccuracy.high,
        interval: 30000, // 30 seconds
        distanceFilter: 0,
      );

      // Start location updates
      _locationSubscription =
          location.onLocationChanged.listen((LocationData locationData) async {
        print(
            'Location updated: ${locationData.latitude}, ${locationData.longitude}');
        await _processLocation(locationData);
      });
    } catch (e) {
      print('Failed to initialize location service: $e');
    }
  }

  static Future<void> _fetchAppointments() async {
    try {
      print('Fetching appointments...');
      final visitorCubit = VisitorCubitSingleton.getInstance();
      await visitorCubit.fetchAppointments();
      final state = visitorCubit.state;

      if (state is VisitorAppointmentFetchLoadedState) {
        _appointments = state.appointmentData.where((appointment) {
          return appointment.status == 'entered' ||
              appointment.status == 'running' ||
              appointment.status == 'redListed';
        }).toList();
        print('Appointments fetched successfully: ${_appointments.length}');
      } else {
        print('Failed to fetch appointments or no appointments found');
      }
    } catch (e) {
      print('Error fetching appointments: $e');
    }
  }

  static Future<void> _processLocation(LocationData locationData) async {
    try {
      final box = await Hive.openBox<LocationModel>('locationBox');
      print('Opened Hive box: ${box.name}');

      // Use the previously fetched appointments
      for (final appointment in _appointments) {
        final location = LocationModel(
          latitude: locationData.latitude!,
          longitude: locationData.longitude!,
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
          await LocationCallbackHandler.sendLocationToServer(location);
          location.delete();
          print('Location sent to server and deleted from box');
        }
      } else {
        print('No internet connection available');
      }
    } catch (e) {
      print('Error processing location: $e');
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

  static Future<void> stopLocationService() async {
    try {
      print('Stopping location service...');
      await _locationSubscription?.cancel();
      print('Location service stopped successfully');
    } catch (e) {
      print('Failed to stop location service: $e');
    }
  }
}

class LocationCallbackHandler {
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
}

class VisitorCubitSingleton {
  static final VisitorCubit _visitorCubit = VisitorCubit();

  static VisitorCubit getInstance() => _visitorCubit;
}
