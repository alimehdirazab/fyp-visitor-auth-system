import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/data/models/staff/staff_model.dart';
import 'package:fyp/data/repositories/staff_repository.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_state.dart';
import 'package:fyp/logic/services/staff_preferences.dart';

class StaffCubit extends Cubit<StaffState> {
  StaffCubit() : super(StaffInitialState()) {
    _initialize();
  }

  final StaffRepository _staffRepository = StaffRepository();

  void _initialize() async {
    final userDetails = await StaffPreferences.fetchStaffDetails();
    String? accessToken = userDetails["accessToken"];
    String? refreshToken = userDetails["refreshToken"];
    String? email = userDetails["email"]; // Add this
    String? password = userDetails["password"]; // Add this
    //String? role = userDetails["role"];

    if (email == null ||
        password == null ||
        accessToken == null ||
        refreshToken == null) {
      emit(StaffLoggedOutState());
    } else {
      signIn(
          email: email,
          password: password); // Call signIn with email and password
    }
  }

  void _emitLoggedInState({
    required StaffData staffData,
    required String accessToken,
    required String refreshToken,
    required String email,
    required String password,
    required String role,
    required String staffId,
    required String name,
    required String profilePic,
    required String cnicFrontPicture,
    required String cnicBackPicture,
  }) async {
    await StaffPreferences.saveStaffDetails(
      staffId,
      name,
      profilePic,
      cnicFrontPicture,
      cnicBackPicture,
      email,
      role,
      accessToken,
      refreshToken,
      password,
    ); // Store email and password
    emit(StaffLoggedInState(staffData));
    log('Details Saved!');
  }

  void signIn({required String email, required String password}) async {
    emit(StaffLoadingState());
    try {
      StaffData staffData =
          await _staffRepository.signIn(email: email, password: password);

      String accessToken = staffData.accessToken.toString();
      String refreshToken = staffData.refreshToken.toString();
      String role = staffData.role.toString();
      String staffId = staffData.id.toString();
      String name = staffData.name.toString();
      String profilePic = staffData.profilePic.toString();
      String cnicFrontPicture = staffData.cnicFrontPic.toString();
      String cnicBackPicture = staffData.cnicBackPic.toString();

      _emitLoggedInState(
        staffData: staffData,
        accessToken: accessToken,
        refreshToken: refreshToken,
        email: email,
        password: password,
        role: role,
        staffId: staffId,
        name: name,
        profilePic: profilePic,
        cnicFrontPicture: cnicFrontPicture,
        cnicBackPicture: cnicBackPicture,
      );
    } catch (ex) {
      emit(StaffErrorState(ex.toString()));
    }
  }

  Future<void> fetchAppointments() async {
    emit(StaffAppointmentFetchLoadingState());
    try {
      final appointments = await _staffRepository.fetchAppointments();
      emit(StaffAppointmentFetchLoadedState(appointments));
    } catch (e) {
      emit(StaffAppointmentFetchErrorState('Failed to fetch appointments'));
      throw e;
    }
  }

  Future<void> fetchAllAppointments() async {
    emit(StaffAppointmentFetchLoadingState());
    try {
      final appointments = await _staffRepository.fetchAllAppointments();
      emit(StaffAppointmentFetchLoadedState(appointments));
    } catch (e) {
      emit(StaffAppointmentFetchErrorState('Failed to fetch appointments'));
      throw e;
    }
  }

  Future<void> updateAppointment({
    required String appointmentId,
    DateTime? scheduleDate,
    DateTime? scheduleTime,
    String? status,
  }) async {
    emit(UpdateAppointmentLoadingState());
    try {
      await _staffRepository.updateAppointment(
        appointmentId: appointmentId,
        scheduleDate: scheduleDate,
        scheduleTime: scheduleTime,
        status: status,
      );
      emit(UpdateAppointmentSuccessState());
      fetchAppointments(); // Fetch updated appointments after a successful update
    } catch (e) {
      emit(UpdateAppointmentErrorState(e.toString()));
    }
  }

  Future<void> verifyQRCode({required String qrCode}) async {
    emit(VerifyQRCodeLoadingState());
    try {
      await _staffRepository.verifyQRCode(qrCode);
      emit(VerifyQRCodeSuccessState());
    } catch (e) {
      emit(VerifyQRCodeErrorState(e.toString()));
    }
  }

  Future<void> fetchAppointmentVisitorLocation(String appointmentId) async {
    emit(AppointmentLoading());
    try {
      final appointment =
          await _staffRepository.getAppointmentVisitorLocation(appointmentId);
      emit(AppointmentLoaded(appointment.mapTrackings));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  void signOut() async {
    await StaffPreferences.clear();
    _staffRepository.cancelTokenRefreshTimer();
    emit(StaffLoggedOutState());
  }
}
