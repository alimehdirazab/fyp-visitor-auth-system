import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/data/models/visitor/visitor_model.dart';
import 'package:fyp/data/repositories/visitor_repository.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';
import 'package:fyp/logic/services/visitor_preferences.dart';

class VisitorCubit extends Cubit<VisitorState> {
  VisitorCubit() : super(VisitorInitialState()) {
    _initialize();
  }

  final VisitorRepository _visitorRepository = VisitorRepository();

  void _initialize() async {
    final userDetails = await VisitorPreferences.fetchVisitorDetails();
    String? accessToken = userDetails["accessToken"];
    String? refreshToken = userDetails["refreshToken"];
    String? email = userDetails["email"];
    String? password = userDetails["password"];
    bool? emailVerified = userDetails["emailVerified"];

    if (accessToken == null ||
        refreshToken == null ||
        email == null ||
        password == null) {
      emit(VisitorLoggedOutState());
    } else if (emailVerified == false) {
      await VisitorPreferences.clear();
      _visitorRepository.cancelTokenRefreshTimer();
      emit(VisitorLoggedOutState());
    } else {
      signIn(email: email, password: password);
    }
  }

  void _emitLoggedInState({
    required VisitorData visitorData,
    required String accessToken,
    required String refreshToken,
    required String email,
    required String password,
    required String visitorId,
    required bool emailVerified,
    required String phoneNumber,
    required String visitorName,
    required String profilePicture,
    required String cnicBackPicture,
    required String cnicFrontPicture,
  }) async {
    await VisitorPreferences.saveVisitorDetails(
      accessToken,
      refreshToken,
      email,
      password,
      visitorId,
      emailVerified,
      phoneNumber,
      visitorName,
      profilePicture,
      cnicBackPicture,
      cnicFrontPicture,
    );
    emit(VisitorLoggedInState(visitorData));

    log('Details Saved!');
  }

  void signIn({required String email, required String password}) async {
    emit(VisitorLoadingState());
    try {
      VisitorData visitorData =
          await _visitorRepository.signIn(email: email, password: password);

      String accessToken = visitorData.accessToken.toString();
      String refreshToken = visitorData.refreshToken.toString();
      String visitorId = visitorData.id.toString();
      bool emailVerified = visitorData.emailVerified;
      String phoneNumber = visitorData.phone.toString();
      String visitorName = visitorData.name.toString();
      String profilePicture = visitorData.profilePic.toString();
      String cnicBackPicture = visitorData.cnicBackPic.toString();
      String cnicFrontPicture = visitorData.cnicFrontPic.toString();

      if (!emailVerified) {
        emit(VisitorEmailNotVerifiedState());

        await VisitorPreferences.saveVisitorDetails(
          accessToken,
          refreshToken,
          email,
          password,
          visitorId,
          emailVerified,
          phoneNumber,
          visitorName,
          profilePicture,
          cnicBackPicture,
          cnicFrontPicture,
        );
      } else {
        _emitLoggedInState(
          visitorData: visitorData,
          accessToken: accessToken,
          refreshToken: refreshToken,
          email: email,
          password: password,
          visitorId: visitorId,
          emailVerified: emailVerified,
          phoneNumber: phoneNumber,
          visitorName: visitorName,
          profilePicture: profilePicture,
          cnicBackPicture: cnicBackPicture,
          cnicFrontPicture: cnicFrontPicture,
        );
      }
    } catch (ex) {
      emit(VisitorErrorState(ex.toString()));
    }
  }

  void createAccount({required String email, required String password}) async {
    emit(VisitorLoadingState());
    try {
      VisitorData visitorData = await _visitorRepository.createAccount(
          email: email, password: password);

      String accessToken = visitorData.accessToken.toString();
      String refreshToken = visitorData.refreshToken.toString();
      String visitorId = visitorData.id.toString();
      bool emailVerified = visitorData.emailVerified;
      String phoneNumber = visitorData.phone.toString();
      String visitorName = visitorData.name.toString();
      String profilePicture = visitorData.profilePic.toString();
      String cnicBackPicture = visitorData.cnicBackPic.toString();
      String cnicFrontPicture = visitorData.cnicFrontPic.toString();

      if (!emailVerified) {
        emit(VisitorEmailNotVerifiedState());
        await VisitorPreferences.saveVisitorDetails(
          accessToken,
          refreshToken,
          email,
          password,
          visitorId,
          emailVerified,
          phoneNumber,
          visitorName,
          profilePicture,
          cnicBackPicture,
          cnicFrontPicture,
        );
      } else {
        _emitLoggedInState(
          visitorData: visitorData,
          accessToken: accessToken,
          refreshToken: refreshToken,
          email: email,
          password: password,
          visitorId: visitorId,
          emailVerified: emailVerified,
          phoneNumber: phoneNumber,
          visitorName: visitorName,
          profilePicture: profilePicture,
          cnicBackPicture: cnicBackPicture,
          cnicFrontPicture: cnicFrontPicture,
        );
      }
    } catch (ex) {
      emit(VisitorErrorState(ex.toString()));
    }
  }

  void verifyEmail(
      {required String visitorId, required String verificationOTP}) async {
    emit(VisitorLoadingState());
    try {
      bool emailVerified = await _visitorRepository.verifyEmail(
          visitorId: visitorId, verificationOTP: verificationOTP);

      if (emailVerified) {
        emit(VisitorEmailVerifiedState());
      } else {
        emit(VisitorEmailNotVerifiedState());
      }
    } catch (ex) {
      emit(VisitorErrorState(ex.toString()));
    }
  }

  void resendOtp({required String email}) async {
    emit(VisitorLoadingState());
    try {
      int statusCode = await _visitorRepository.resendOtp(email: email);
      emit(VisitorOtpResentState());
      if (statusCode != 200) {
        emit(VisitorErrorState("Failed to resend OTP"));
      }
      emit(VisitorEmailVerifiedState());
    } catch (ex) {
      emit(VisitorErrorState(ex.toString()));
    }
  }

  Future<void> fetchUsers() async {
    emit(VisitorStaffDetailsLoadingState());
    try {
      final users = await _visitorRepository.fetchStaffDetails();
      emit(VisitorStaffDetailsLoadedState(users));
    } catch (e) {
      emit(VisitorStaffDetailsErrorState('Failed to fetch users'));
    }
  }

  Future<String> uploadFile({
    required String fileName,
    required String filePath,
  }) async {
    try {
      emit(VisitorImageUploadLoadingState());
      final String fileUrl = await _visitorRepository.uploadFile(
        fileName: fileName,
        filePath: filePath,
      );
      emit(VisitorImageUploadSuccessState(fileUrl));
      return fileUrl;
    } catch (e) {
      emit(VisitorImageUploadErrorState(e.toString()));
      throw e; // Add a throw statement to ensure that a value is always returned
    }
  }

  Future<void> updateVisitorDetails({
    required String name,
    required String phone,
    required String profilePic,
    required String cnicFrontPic,
    required String cnicBackPic,
  }) async {
    emit(VisitorDetailsUpdatingState());
    try {
      final visitorData = await _visitorRepository.updateVisitorDetails(
        name: name,
        phone: phone,
        profilePic: profilePic,
        cnicFrontPic: cnicFrontPic,
        cnicBackPic: cnicBackPic,
      );
      emit(VisitorDetailsUpdatedState(visitorData));
    } catch (e) {
      // // Log the error message
      // print('Error updating visitor details: $e');

      // Emit the VisitorDetailsUpdateErrorState with the actual error message
      emit(VisitorDetailsUpdateErrorState('Failed to update details: $e'));
    }
  }

  Future<void> saveAppointment({
    required String staffId,
    required String date,
    required String time,
    required String purpose,
  }) async {
    emit(VisitorAppointmentSavingState());
    try {
      final appointmentData = await _visitorRepository.createAppointment(
        staffId: staffId,
        date: date,
        time: time,
        purpose: purpose,
      );
      emit(VisitorAppointmentSavedState(appointmentData));
    } catch (e) {
      emit(VisitorAppointmentSaveErrorState('Failed to save appointment'));
    }
  }

  Future<void> fetchAppointments() async {
    emit(VisitorAppointmentFetchLoadingState());
    try {
      final appointments = await _visitorRepository.fetchAppointments();
      emit(VisitorAppointmentFetchLoadedState(appointments));
    } catch (e) {
      emit(VisitorAppointmentFetchErrorState('Failed to fetch appointments'));
      throw e;
    }
  }

  void signOut() async {
    await VisitorPreferences.clear();
    _visitorRepository.cancelTokenRefreshTimer();
    emit(VisitorLoggedOutState());
  }
}
