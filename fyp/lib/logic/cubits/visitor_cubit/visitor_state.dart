import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/data/models/staff/staff_details_model.dart';
import 'package:fyp/data/models/visitor/visitor_model.dart';
import 'package:fyp/data/models/visitor/visitor_update_details_model.dart';

abstract class VisitorState {}

class VisitorInitialState extends VisitorState {}

class VisitorLoadingState extends VisitorState {}

// Email Verification States
class VisitorEmailVerifiedState extends VisitorState {}

class VisitorEmailNotVerifiedState extends VisitorState {}

class VisitorOtpResentState extends VisitorState {}

/// Image Upload States

class VisitorImageUploadLoadingState extends VisitorState {}

class VisitorImageUploadSuccessState extends VisitorState {
  final String imageUrl;

  VisitorImageUploadSuccessState(this.imageUrl);
}

class VisitorImageUploadErrorState extends VisitorState {
  final String message;
  VisitorImageUploadErrorState(this.message);
}

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
  final VisitorUpdateDetailsModel visitorData;

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

// Appointment Fetch States

class VisitorAppointmentFetchLoadingState extends VisitorState {}

class VisitorAppointmentFetchLoadedState extends VisitorState {
  final List<AppointmentDataModel> appointmentData;

  VisitorAppointmentFetchLoadedState(this.appointmentData);
}

class VisitorAppointmentFetchErrorState extends VisitorState {
  final String message;
  VisitorAppointmentFetchErrorState(this.message);
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
