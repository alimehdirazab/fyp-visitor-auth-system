import 'package:flutter/material.dart';

import 'package:fyp/presentation/pages/Visitors_Screens/home/visitor_account_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/visitor_appointments_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/visitor_form_screen.dart';

class VisitorHomeScreen extends StatefulWidget {
  const VisitorHomeScreen({super.key});

  static const String routeName = "visitorHomeScreen";

  @override
  State<VisitorHomeScreen> createState() => _VisitorHomeScreenState();
}

class _VisitorHomeScreenState extends State<VisitorHomeScreen> {
  int currentIndex = 1;

  final PageStorageBucket _bucket = PageStorageBucket();

  List<Widget> screens = const [
    VisitorAppointmentsScreen(),
    VisitorFormScreen(),
    VisitorAccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: PageStorage(
        bucket: _bucket,
        child: SafeArea(child: screens[currentIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            label: "Appointments",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              size: 35,
            ),
            label: "Fill Form",
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
    );
  }
}
