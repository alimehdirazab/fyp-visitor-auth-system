import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';

class VisitorAppointmentFormProvider extends ChangeNotifier {
  final BuildContext context;
  VisitorAppointmentFormProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String? error = "";
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final purposeController = TextEditingController();

  String? userId;
  String? visitorId;
  DateTime? appointmentDate;
  TimeOfDay? appointmentTime;
  String? profilePic;
  String? cnicFrontPic;
  String? cnicBackPic;

  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    _userSubscription =
        BlocProvider.of<VisitorCubit>(context).stream.listen((userState) {
      if (userState is VisitorLoadingState) {
        isLoading = true;
        error = "";
        notifyListeners();
      } else if (userState is VisitorErrorState) {
        isLoading = false;
        error = userState.message;
        notifyListeners();
      } else {
        isLoading = false;
        error = "";
        notifyListeners();
      }
    });
  }

  void updateVisitorDetails() {
    if (!formKey.currentState!.validate()) return;

    String name = nameController.text.trim();
    String phone = phoneController.text.trim();

    // Check if required image fields are null
    if (profilePic == null || cnicFrontPic == null || cnicBackPic == null) {
      error = "Please upload all required images";
      notifyListeners();
      return;
    }

    // Logging for debugging
    debugPrint("Updating visitor details with:");
    debugPrint(
        "Name: $name, Phone: $phone, ProfilePic: $profilePic, CNIC Front: $cnicFrontPic, CNIC Back: $cnicBackPic");

    BlocProvider.of<VisitorCubit>(context).updateVisitorDetails(
      name: name,
      phone: phone,
      profilePic: profilePic!,
      cnicFrontPic: cnicFrontPic!,
      cnicBackPic: cnicBackPic!,
    );
  }

  void saveAppointment() async {
    if (!formKey.currentState!.validate()) return;

    String purpose = purposeController.text.trim();

    // Check if userId, appointmentDate, or appointmentTime are null
    if (userId == null || appointmentDate == null || appointmentTime == null) {
      error = "Please complete all appointment details";
      notifyListeners();
      return;
    }

    // Logging for debugging
    debugPrint("Saving appointment with:");
    debugPrint(
        "UserId: $userId, Date: $appointmentDate, Time: $appointmentTime, Purpose: $purpose");

    BlocProvider.of<VisitorCubit>(context).saveAppointment(
      staffId: userId!,
      date: appointmentDate.toString(),
      time: appointmentTime.toString(),
      purpose: purpose,
    );
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
