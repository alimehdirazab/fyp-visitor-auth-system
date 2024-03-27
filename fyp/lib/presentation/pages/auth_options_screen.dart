import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/visitor_login_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/visitor_signup_screen.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/link_button.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';

class AuthOptionScreen extends StatefulWidget {
  const AuthOptionScreen({super.key});
  static const String routeName = "AuthOptionScreen";

  @override
  State<AuthOptionScreen> createState() => _AuthOptionScreenState();
}

class _AuthOptionScreenState extends State<AuthOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/auth.png'),
                Text('Visitor Authentication \n      SMI University',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 150),
                PrimaryButton(
                    text: 'Create Account',
                    onPressed: () {
                      Navigator.pushNamed(
                          context, VisitorSignupScreen.routeName);
                    }),
                const GapWidget(),
                LinkButton(
                    text: 'Login',
                    onPressed: () {
                      Navigator.pushNamed(
                          context, VisitorLoginScreen.routeName);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
