import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/visitor_home_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/otp_screen.dart';
import 'package:fyp/presentation/pages/select_user_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/visitor_login_screen.dart';

class VisitorLoadingScreen extends StatefulWidget {
  const VisitorLoadingScreen({super.key});

  static const String routeName = "VisitorloadingScreen";

  @override
  State<VisitorLoadingScreen> createState() => _VisitorLoadingScreenState();
}

class _VisitorLoadingScreenState extends State<VisitorLoadingScreen> {
  void goToNextScreen() {
    // Visitors Screen Navigation
    VisitorState visitorState = BlocProvider.of<VisitorCubit>(context).state;
    if (visitorState is VisitorLoggedInState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, VisitorHomeScreen.routeName);
    } else if (visitorState is VisitorEmailNotVerifiedState) {
      Navigator.pushReplacementNamed(context, OtpScreen.routeName);
    } else if (visitorState is VisitorEmailVerifiedState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, VisitorHomeScreen.routeName);
    } else if (visitorState is VisitorLoggedOutState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, SelectUserScreen.routeName);
    } else if (visitorState is VisitorErrorState) {
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
    return MultiBlocListener(
      listeners: [
        BlocListener<VisitorCubit, VisitorState>(
          listener: (context, state) {
            goToNextScreen();
          },
        ),
      ],
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
