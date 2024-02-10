import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';

class VisitorSignupProvider with ChangeNotifier {
  final BuildContext context;
  VisitorSignupProvider(this.context) {
    _listenToUserCubit();
  }
  bool isLoading = false;
  String error = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
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

  void createAccount() async {
    if (!formKey.currentState!.validate()) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    BlocProvider.of<VisitorCubit>(context)
        .createAccount(email: email, password: password);
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
