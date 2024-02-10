import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_state.dart';

class StaffLoginProvider with ChangeNotifier {
  final BuildContext context;
  StaffLoginProvider(this.context) {
    _listenToUserCubit();
  }
  bool isLoading = false;
  String error = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    _userSubscription =
        BlocProvider.of<StaffCubit>(context).stream.listen((staffState) {
      if (staffState is StaffLoadingState) {
        isLoading = true;
        error = "";
        notifyListeners();
      } else if (staffState is StaffErrorState) {
        isLoading = false;
        error = staffState.message;
        notifyListeners();
      } else {
        isLoading = false;
        error = "";

        notifyListeners();
      }
    });
  }

  void logIn() async {
    if (!formKey.currentState!.validate()) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    BlocProvider.of<StaffCubit>(context)
        .signIn(email: email, password: password);
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
