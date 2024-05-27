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

  String? userId = "";
  String? visitorId = "";
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

    BlocProvider.of<VisitorCubit>(context).updateVisitorDetails(
        name: name,
        phone: phone,
        profilePic: profilePic!,
        cnicFrontPic: cnicFrontPic!,
        cnicBackPic: cnicBackPic!);
  }

  void saveAppointment() async {
    if (!formKey.currentState!.validate()) return;

    String purpose = purposeController.text.trim();

    BlocProvider.of<VisitorCubit>(context).saveAppointment(
        staffId: userId!,
        date: appointmentDate.toString(),
        time: appointmentTime.toString(),
        purpose: purpose);
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
