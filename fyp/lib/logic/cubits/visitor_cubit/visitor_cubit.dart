import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
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
  }) async {
    await VisitorPreferences.saveVisitorDetails(
        accessToken, refreshToken, email, password, visitorId, emailVerified);
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
      bool emailVerified = visitorData.emailVerified!;

      if (visitorData.emailVerified == false) {
        emit(VisitorEmailNotVerifiedState());
        await VisitorPreferences.saveVisitorDetails(accessToken, refreshToken,
            email, password, visitorId, emailVerified);
      } else {
        _emitLoggedInState(
          visitorData: visitorData,
          accessToken: accessToken,
          refreshToken: refreshToken,
          email: email,
          password: password,
          visitorId: visitorId,
          emailVerified: emailVerified,
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
      bool emailVerified = visitorData.emailVerified!;

      if (visitorData.emailVerified == false) {
        emit(VisitorEmailNotVerifiedState());
        await VisitorPreferences.saveVisitorDetails(accessToken, refreshToken,
            email, password, visitorId, emailVerified);
      } else {
        _emitLoggedInState(
          visitorData: visitorData,
          accessToken: accessToken,
          refreshToken: refreshToken,
          email: email,
          password: password,
          visitorId: visitorId,
          emailVerified: emailVerified,
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
    try {
      emit(VisitorLoadingState());
      final users = await _visitorRepository.fetchStaffDetails();
      emit(VisitorStaffDetailsLoadedState(users));
    } catch (e) {
      emit(VisitorErrorState('Failed to fetch users'));
    }
  }

  void signOut() async {
    await VisitorPreferences.clear();
    _visitorRepository.cancelTokenRefreshTimer();
    emit(VisitorLoggedOutState());
  }
}
