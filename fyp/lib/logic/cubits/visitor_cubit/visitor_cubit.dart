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

    if (accessToken == null ||
        refreshToken == null ||
        email == null ||
        password == null) {
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
  }) async {
    await VisitorPreferences.saveVisitorDetails(
      accessToken,
      refreshToken,
      email,
      password,
      visitorId,
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

      if (visitorData.emailVerified == false) {
        emit(VisitorEmailNotVerifiedState());
        await VisitorPreferences.saveVisitorDetails(
            accessToken, refreshToken, email, password, visitorId);
      } else {
        _emitLoggedInState(
          visitorData: visitorData,
          accessToken: accessToken,
          refreshToken: refreshToken,
          email: email,
          password: password,
          visitorId: visitorId,
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

      if (visitorData.emailVerified == false) {
        emit(VisitorEmailNotVerifiedState());
        await VisitorPreferences.saveVisitorDetails(
            accessToken, refreshToken, email, password, visitorId);
      } else {
        _emitLoggedInState(
          visitorData: visitorData,
          accessToken: accessToken,
          refreshToken: refreshToken,
          email: email,
          password: password,
          visitorId: visitorId,
        );
      }
    } catch (ex) {
      emit(VisitorErrorState(ex.toString()));
    }
  }

  void verifyEmail(
      {required int visitorId, required String verificationOTP}) async {
    emit(VisitorLoadingState());
    try {
      bool emailVerified = await _visitorRepository.verifyEmail(
          visitorId: visitorId, verificationOTP: verificationOTP);

      if (emailVerified) {
        emit(VisitorEmailVerifiedState());
      } else {
        emit(VisitorErrorState('Failed to verify email'));
      }
    } catch (ex) {
      emit(VisitorErrorState(ex.toString()));
    }
  }

  void signOut() async {
    await VisitorPreferences.clear();
    _visitorRepository.cancelTokenRefreshTimer();
    emit(VisitorLoggedOutState());
  }
}
