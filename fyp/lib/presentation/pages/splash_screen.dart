// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/logic/services/staff_preferences.dart';
import 'package:fyp/logic/services/visitor_preferences.dart';
import 'package:fyp/main.dart';
import 'package:fyp/presentation/pages/LoadingScreens/visitor_loading_screen.dart';
import 'package:fyp/presentation/pages/LoadingScreens/staff_loading_screen.dart';
import 'package:fyp/presentation/pages/auth_options_screen.dart';
import 'package:fyp/presentation/pages/select_user_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "splashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnPreferences();
  }

  Future<void> _navigateBasedOnPreferences() async {
    await Future.delayed(const Duration(seconds: 4));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    // Fetch preferences
    final visitorDetails = await VisitorPreferences.fetchVisitorDetails();
    final staffDetails = await StaffPreferences.fetchStaffDetails();

    // Navigate based on the presence of visitor or staff data
    if (visitorDetails['email'] != '') {
      Navigator.pushReplacementNamed(context, VisitorLoadingScreen.routeName);
    } else if (staffDetails['email'] != '') {
      Navigator.pushReplacementNamed(context, StaffLoadingScreen.routeName);
    } else {
      // Handle the case when neither visitor nor staff data is present
      // For example, you could navigate to a login screen or an error screen
      Navigator.pushReplacementNamed(context, SelectUserScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/splash_logo.png'),
      ),
    );
  }
}
