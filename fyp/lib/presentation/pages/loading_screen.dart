import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/data/models/staff/staff_model.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_state.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_home_screen.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_home_screen.dart';
import 'package:fyp/presentation/pages/Staff/auth/staff_login_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/visitor_login_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/visitor_home_screen.dart';
import 'package:fyp/presentation/pages/otp_screen.dart';
import 'package:fyp/presentation/pages/select_user_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  static const String routeName = "loadingScreen";

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void goToNextScreen() {
    //Visitors Screen Navigation
    VisitorState visitorState = BlocProvider.of<VisitorCubit>(context).state;
    if (visitorState is VisitorLoggedInState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, VisitorHomeScreen.routeName);
    } else if (visitorState is VisitorEmailVerifiedState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, OtpScreen.routeName);
    } else if (visitorState is VisitorLoggedOutState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, SelectUserScreen.routeName);
    } else if (visitorState is VisitorErrorState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, VisitorLoginScreen.routeName);
    }
    //Staff Screens Navigation
    StaffState staffState = BlocProvider.of<StaffCubit>(context).state;
    if (staffState is StaffLoggedInState) {
      StaffData staffData = staffState.staffData;
      // log(staffModel.data!.role.toString());
      if (staffData.role == 'staff') {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacementNamed(context, StaffHomeScreen.routeName);
      } else if (staffData.role == 'guard') {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacementNamed(context, SecurityHomeScreen.routeName);
      } else {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacementNamed(context, SelectUserScreen.routeName);
      }
    } else if (staffState is StaffLoggedOutState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, SelectUserScreen.routeName);
    } else if (staffState is StaffErrorState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, StaffLoginScreen.routeName);
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
    return BlocListener<VisitorCubit, VisitorState>(
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
