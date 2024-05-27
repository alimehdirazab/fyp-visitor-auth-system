import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/data/models/staff/staff_details_model.dart';
import 'package:fyp/data/models/visitor/visitor_model.dart';

abstract class VisitorState {}

class VisitorInitialState extends VisitorState {}

class VisitorLoadingState extends VisitorState {}

class VisitorEmailVerifiedState extends VisitorState {}

class VisitorEmailNotVerifiedState extends VisitorState {}

class VisitorOtpResentState extends VisitorState {}

class VisitorStaffDetailsLoadedState extends VisitorState {
  final List<StaffDetailsData> staff;

  VisitorStaffDetailsLoadedState(this.staff);
}

class VisitorDetailsUpdatedState extends VisitorState {
  /// i use StaffDetailsData in this case because Visitor and a Staff have the same structure
  final StaffDetailsData visitorData;

  VisitorDetailsUpdatedState(this.visitorData);
}

class VisitorAppointmentSavedState extends VisitorState {
  final AppointmentDataModel appointmentData;

  VisitorAppointmentSavedState(this.appointmentData);
}

class VisitorLoggedInState extends VisitorState {
  VisitorData visitorData;
  VisitorLoggedInState(this.visitorData);
}

class VisitorLoggedOutState extends VisitorState {}

class VisitorErrorState extends VisitorState {
  final String message;
  VisitorErrorState(this.message);
}
