import 'package:fyp/data/models/visitor/visitor_model.dart';

abstract class VisitorState {}

class VisitorInitialState extends VisitorState {}

class VisitorLoadingState extends VisitorState {}

class VisitorLoggedInState extends VisitorState {
  VisitorModel visitorModel;
  VisitorLoggedInState(this.visitorModel);
}

class VisitorLoggedOutState extends VisitorState {}

class VisitorErrorState extends VisitorState {
  final String message;
  VisitorErrorState(this.message);
}
