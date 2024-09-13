import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';
import 'package:intl/intl.dart';

class VisitorAppointmentFormProvider extends ChangeNotifier {
  final BuildContext context;
  VisitorAppointmentFormProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = "";
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final purposeController = TextEditingController();

  String? userId;
  String? visitorId;
  DateTime? appointmentDate;
  TimeOfDay? appointmentTime;

  // Update these fields to Map<String, dynamic> for profile pics
  Map<String, dynamic>? profilePic;
  Map<String, dynamic>? cnicFrontPic;
  Map<String, dynamic>? cnicBackPic;

  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    _userSubscription =
        BlocProvider.of<VisitorCubit>(context).stream.listen((userState) {
      if (userState is VisitorLoadingState ||
          userState is VisitorImageUploadLoadingState ||
          userState is VisitorDetailsUpdatingState ||
          userState is VisitorAppointmentSavingState) {
        isLoading = true;
        error = "";
        notifyListeners();
      } else if (userState is VisitorErrorState) {
        isLoading = false;
        error = userState.message;
        notifyListeners();
      } else if (userState is VisitorImageUploadErrorState) {
        isLoading = false;
        error = userState.message;
        notifyListeners();
      } else if (userState is VisitorDetailsUpdateErrorState) {
        isLoading = false;
        error = userState.message;
        notifyListeners();
      } else if (userState is VisitorAppointmentSaveErrorState) {
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
      if (profilePic == null) {
        error = "Please upload Selfie";
        notifyListeners();
        return;
      } else if (cnicFrontPic == null) {
        error = "Please upload CNIC Front Pic";
        notifyListeners();
        return;
      } else if (cnicBackPic == null) {
        error = "Please upload CNIC Back Pic";
        notifyListeners();
        return;
      }
    }

    // Call the function to update visitor details, ensuring fileUrl is passed correctly
    BlocProvider.of<VisitorCubit>(context).updateVisitorDetails(
      name: name,
      phone: phone,
      profilePic: profilePic!['fileUrl'], // Extract fileUrl
      cnicFrontPic: cnicFrontPic!['fileUrl'], // Extract fileUrl
      cnicBackPic: cnicBackPic!['fileUrl'], // Extract fileUrl
    );
  }

  void saveAppointment() async {
    if (!formKey.currentState!.validate()) return;

    String purpose = purposeController.text.trim();

    // Check if userId, appointmentDate, or appointmentTime are null
    if (userId == null || appointmentDate == null || appointmentTime == null) {
      if (userId == null) {
        error = "Please select a user";
        notifyListeners();
        return;
      } else if (appointmentDate == null) {
        error = "Please select a date";
        notifyListeners();
        return;
      } else if (appointmentTime == null) {
        error = "Please select a time";
        notifyListeners();
        return;
      }
    }

    // Combine appointmentDate and appointmentTime into a single DateTime object
    DateTime combinedDateTime = DateTime(
      appointmentDate!.year,
      appointmentDate!.month,
      appointmentDate!.day,
      appointmentTime!.hour,
      appointmentTime!.minute,
    );

    // Format the combined DateTime as "yyyy-MM-ddTHH:mm:ssZ"
    String formattedDateTime =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(combinedDateTime);

    // Call the saveAppointment function
    BlocProvider.of<VisitorCubit>(context).saveAppointment(
      staffId: userId!,
      date: formattedDateTime,
      time: formattedDateTime,
      purpose: purpose,
    );
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
