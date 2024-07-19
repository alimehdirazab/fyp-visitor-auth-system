import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/data/models/staff/staff_model.dart';

abstract class StaffState {}

class StaffInitialState extends StaffState {}

class StaffLoadingState extends StaffState {}

class StaffLoggedInState extends StaffState {
  StaffData staffData;
  StaffLoggedInState(this.staffData);
}

class StaffLoggedOutState extends StaffState {}

class StaffErrorState extends StaffState {
  final String message;
  StaffErrorState(this.message);
}

//----------------------------------------------------------------
//GetUserByIdStates
//----------------------------------------------------------------

class GetStaffByIdLoadingState extends StaffState {}

class GetStaffByIdSuccessState extends StaffState {
  StaffData staffData;
  GetStaffByIdSuccessState(this.staffData);
}

class GetStaffByIdErrorState extends StaffState {
  final String message;
  GetStaffByIdErrorState(this.message);
}

//----------------------------------------------------------------

class StaffAppointmentFetchLoadingState extends StaffState {}

class StaffAppointmentFetchLoadedState extends StaffState {
  final List<AppointmentDataModel> appointmentData;
  StaffAppointmentFetchLoadedState(this.appointmentData);
}

class StaffAppointmentFetchErrorState extends StaffState {
  final String message;
  StaffAppointmentFetchErrorState(this.message);
}

//----------------------------------------------------------------

class UpdateAppointmentLoadingState extends StaffState {}

class UpdateAppointmentSuccessState extends StaffState {}

class UpdateAppointmentErrorState extends StaffState {
  final String message;
  UpdateAppointmentErrorState(this.message);
}

//-----------------------------------------------------

class VerifyQRCodeLoadingState extends StaffState {}

class VerifyQRCodeSuccessState extends StaffState {}

class VerifyQRCodeErrorState extends StaffState {
  final String message;
  VerifyQRCodeErrorState(this.message);
}

//-------------------------------------------------------

class AppointmentLoading extends StaffState {}

class AppointmentLoaded extends StaffState {
  final List<Map<String, dynamic>> mapTrackings;

  AppointmentLoaded(this.mapTrackings);
}

class AppointmentError extends StaffState {
  final String message;

  AppointmentError(this.message);
}
