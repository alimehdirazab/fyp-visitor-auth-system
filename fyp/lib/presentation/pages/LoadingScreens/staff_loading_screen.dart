import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/data/models/staff/staff_model.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_state.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_home_screen.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_home_screen.dart';
import 'package:fyp/presentation/pages/select_user_screen.dart';

class StaffLoadingScreen extends StatefulWidget {
  const StaffLoadingScreen({super.key});

  static const String routeName = "StaffloadingScreen";

  @override
  State<StaffLoadingScreen> createState() => _StaffLoadingScreenState();
}

class _StaffLoadingScreenState extends State<StaffLoadingScreen> {
  void goToNextScreen() {
    // Staff Screens Navigation
    StaffState staffState = BlocProvider.of<StaffCubit>(context).state;
    if (staffState is StaffLoggedInState) {
      StaffData staffData = staffState.staffData;
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
    } //else {
    //   Navigator.popUntil(context, (route) => route.isFirst);
    //   Navigator.pushReplacementNamed(context, SelectUserScreen.routeName);
    // }
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
        BlocListener<StaffCubit, StaffState>(
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
