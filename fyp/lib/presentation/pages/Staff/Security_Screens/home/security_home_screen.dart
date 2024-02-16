import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_exchange_duty_page.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_home_page.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_profile_page.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_scan_visitor_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SecurityHomeScreen extends StatefulWidget {
  const SecurityHomeScreen({super.key});
  static const String routeName = "securityHomeScreen";

  @override
  State<SecurityHomeScreen> createState() => _SecurityHomeScreenState();
}

class _SecurityHomeScreenState extends State<SecurityHomeScreen> {
  int currentIndex = 0;
  List<Widget> pages = const [
    SecurityHomePage(),
    SecurityExchangeDutyPage(),
    SecurtiyScanVisitorPage(),
    SecurityProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Home Screen'),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              // horizontal: 15,
              //vertical: 20,
              ),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.list,
                text: "Scan",
              ),
              GButton(
                icon: Icons.insert_invitation,
                text: "Change Duty",
              ),
              GButton(
                icon: Icons.supervised_user_circle,
                text: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
