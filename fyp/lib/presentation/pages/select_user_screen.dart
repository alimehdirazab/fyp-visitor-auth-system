import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_home_screen.dart';
import 'package:fyp/presentation/pages/Staff/auth/staff_login_screen.dart';
import 'package:fyp/presentation/pages/auth_options_screen.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';

class SelectUserScreen extends StatefulWidget {
  const SelectUserScreen({super.key});

  static const String routeName = "selectUserScreen";

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const GapWidget(size: 20),
                  Text(
                    'WELCOME',
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const Text(
                    'Visitor Authorization System',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const GapWidget(size: 30),
                  Image.asset('assets/images/click_hand.png'),
                  const GapWidget(size: 30),
                  PrimaryButton(
                      text: 'Visitor',
                      icon: 'assets/icons/visitor_icon.png',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AuthOptionScreen.routeName);
                      }),
                  const GapWidget(size: 10),
                  PrimaryButton(
                      text: 'Staff',
                      icon: 'assets/icons/staff_icon.png',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, StaffLoginScreen.routeName);
                      }),
                  const GapWidget(size: 10),
                  PrimaryButton(
                      text: 'Security',
                      icon: 'assets/icons/security_icon.png',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, StaffLoginScreen.routeName);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
