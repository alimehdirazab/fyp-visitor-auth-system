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
    SecurityProfilePage(),
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
            // backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 35,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 35,
                ),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(), // Empty icon
                label: '', // Empty label
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month_sharp,
                  size: 35,
                ),
                label: "Invites",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 35,
                ),
                label: "Profile",
              ),
            ],
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
