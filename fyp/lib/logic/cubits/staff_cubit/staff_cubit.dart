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
  }) async {
    await StaffPreferences.saveStaffDetails(
      accessToken,
      refreshToken,
      email,
      password,
      role,
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

      _emitLoggedInState(
          staffData: staffData,
          accessToken: accessToken,
          refreshToken: refreshToken,
          email: email,
          password: password,
          role: role);
    } catch (ex) {
      emit(StaffErrorState(ex.toString()));
    }
  }

  // void createAccount(
  //     {required String email,
  //     required String password,
  //     required String role}) async {
  //   emit(StaffLoadingState());
  //   try {
  //     StaffModel staffModel = await _staffRepository.createAccount(
  //         email: email, password: password, role: role);
  //     _emitLoggedInState(
  //         staffModel: staffModel, email: email, password: password);
  //   } catch (ex) {
  //     emit(StaffErrorState(ex.toString()));
  //   }
  // }

  void signOut() async {
    await StaffPreferences.clear();
    _staffRepository.cancelTokenRefreshTimer();
    emit(StaffLoggedOutState());
  }
}
