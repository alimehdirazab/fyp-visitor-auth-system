import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/main.dart';
import 'package:fyp/presentation/pages/loading_screen.dart';

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
    Future.delayed(const Duration(seconds: 4), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      );
      Navigator.pushReplacementNamed(context, LoadingScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          //app icon
          Positioned(
            width: mq.width * 0.50,
            top: mq.height * 0.15,
            right: mq.width * 0.25,
            child: Image.asset('assets/images/smiu_logo.png'),
          ),
          Positioned(
            width: mq.width * 0.50,
            top: mq.height * 0.35,
            right: mq.width * 0.30,
            child: Image.asset('assets/images/smiu_qrcode.png'),
          ),
          Positioned(
            bottom: mq.height * 0.15,
            width: mq.width,
            child: const Text(
              'SMIU\nVisitor Authorization System',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18, color: Colors.black54, letterSpacing: 2),
            ),
          ),
        ],
      ),
    );
  }
}
