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
    String? email = userDetails["email"];
    String? password = userDetails["password"];
    //String? role = userDetails["role"];
    if (email == null || password == null) {
      emit(StaffLoggedOutState());
    } else {
      signIn(email: email, password: password);
    }
  }

  void _emitLoggedInState({
    required StaffModel staffModel,
    required String email,
    required String password,
  }) async {
    await StaffPreferences.saveStaffDetails(email, password);
    emit(StaffLoggedInState(staffModel));
    log('Details Saved!');
  }

  void signIn({required String email, required String password}) async {
    emit(StaffLoadingState());
    try {
      StaffModel staffModel =
          await _staffRepository.signIn(email: email, password: password);

      log(staffModel.message.toString());
      _emitLoggedInState(
          staffModel: staffModel, email: email, password: password);
    } catch (ex) {
      emit(StaffErrorState(ex.toString()));
    }
  }

  void createAccount(
      {required String email,
      required String password,
      required String role}) async {
    emit(StaffLoadingState());
    try {
      StaffModel staffModel = await _staffRepository.createAccount(
          email: email, password: password, role: role);
      _emitLoggedInState(
          staffModel: staffModel, email: email, password: password);
    } catch (ex) {
      emit(StaffErrorState(ex.toString()));
    }
  }

  void signOut() async {
    await StaffPreferences.clear();
    emit(StaffLoggedOutState());
  }
}
