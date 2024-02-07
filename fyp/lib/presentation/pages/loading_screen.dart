import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/logic/cubits/user_cubit/user_cubit.dart';
import 'package:fyp/logic/cubits/user_cubit/user_state.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/visitor_login_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/visitor_home_screen.dart';
import 'package:fyp/presentation/pages/select_user_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  static const String routeName = "loadingScreen";

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void goToNextScreen() {
    UserState userState = BlocProvider.of<UserCubit>(context).state;
    if (userState is UserLoggedInState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, VisitorHomeScreen.routeName);
    } else if (userState is UserLoggedOutState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, SelectUserScreen.routeName);
    } else if (userState is UserErrorState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, VisitorLoginScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 100), () {
      goToNextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        goToNextScreen();
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
