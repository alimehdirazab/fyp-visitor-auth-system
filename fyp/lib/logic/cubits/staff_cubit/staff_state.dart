import 'package:fyp/data/models/staff/staff_model.dart';

abstract class StaffState {}

class StaffInitialState extends StaffState {}

class StaffLoadingState extends StaffState {}

class StaffLoggedInState extends StaffState {
  StaffModel staffModel;
  StaffLoggedInState(this.staffModel);
}

class StaffLoggedOutState extends StaffState {}

class StaffErrorState extends StaffState {
  final String message;
  StaffErrorState(this.message);
}
