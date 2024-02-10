import 'package:flutter/material.dart';

class SecurityHomeScreen extends StatefulWidget {
  const SecurityHomeScreen({super.key});
  static const String routeName = "securityHomeScreen";

  @override
  State<SecurityHomeScreen> createState() => _SecurityHomeScreenState();
}

class _SecurityHomeScreenState extends State<SecurityHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Home Screen'),
      ),
    );
  }
}
