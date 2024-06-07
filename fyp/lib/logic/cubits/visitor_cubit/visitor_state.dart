import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/data/models/staff/staff_details_model.dart';
import 'package:fyp/data/models/visitor/visitor_model.dart';

abstract class VisitorState {}

class VisitorInitialState extends VisitorState {}

class VisitorLoadingState extends VisitorState {}

// Email Verification States
class VisitorEmailVerifiedState extends VisitorState {}

class VisitorEmailNotVerifiedState extends VisitorState {}

class VisitorOtpResentState extends VisitorState {}

// Staff Details States
class VisitorStaffDetailsLoadingState extends VisitorState {}

class VisitorStaffDetailsLoadedState extends VisitorState {
  final List<StaffDetailsData> staff;

  VisitorStaffDetailsLoadedState(this.staff);
}

class VisitorStaffDetailsErrorState extends VisitorState {
  final String message;
  VisitorStaffDetailsErrorState(this.message);
}

// Visitor Details Update States
class VisitorDetailsUpdatingState extends VisitorState {}

class VisitorDetailsUpdatedState extends VisitorState {
  /// Using StaffDetailsData in this case because Visitor and a Staff have the same structure
  final StaffDetailsData visitorData;

  VisitorDetailsUpdatedState(this.visitorData);
}

class VisitorDetailsUpdateErrorState extends VisitorState {
  final String message;
  VisitorDetailsUpdateErrorState(this.message);
}

// Appointment States
class VisitorAppointmentSavingState extends VisitorState {}

class VisitorAppointmentSavedState extends VisitorState {
  final AppointmentDataModel appointmentData;

  VisitorAppointmentSavedState(this.appointmentData);
}

class VisitorAppointmentSaveErrorState extends VisitorState {
  final String message;
  VisitorAppointmentSaveErrorState(this.message);
}

// Authentication States
class VisitorLoggedInState extends VisitorState {
  final VisitorData visitorData;
  VisitorLoggedInState(this.visitorData);
}

class VisitorLoggedOutState extends VisitorState {}

class VisitorErrorState extends VisitorState {
  final String message;
  VisitorErrorState(this.message);
}
