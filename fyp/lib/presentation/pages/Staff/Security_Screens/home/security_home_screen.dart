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
  int _selectedIndex = 0;
  List<Widget> pages = const [
    SecurityHomePage(),
    SecurityExchangeDutyPage(),
    SecurtiyScanVisitorPage(),
    SecurityProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Home Screen'),
      ),
      body: pages[_selectedIndex],
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            // Add your functionality here
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.search),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(), // Empty icon
                label: '', // Empty label
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedIconTheme: IconThemeData(color: Colors.green),
            unselectedIconTheme: IconThemeData(color: Colors.grey),
            backgroundColor: Colors.white,
            selectedLabelStyle: TextStyle(color: Colors.black),
            unselectedLabelStyle: TextStyle(color: Colors.black),
          ),
          // Positioned(
          //   bottom: 16,
          //   child: FloatingActionButton(
          //     onPressed: () {
          //       // Add your functionality here
          //     },
          //     backgroundColor: Colors.green,
          //     child: Icon(Icons.search),
          //   ),
          // ),
        ],
      ),
    );
  }
}
