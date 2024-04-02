import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_home_page.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_invite_visitor_page.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_profile_page.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_search_page.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/staf_notification_screen.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/widgets/my_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class StaffHomeScreen extends StatefulWidget {
  const StaffHomeScreen({super.key});
  static const String routeName = "staffHomeScreen";
  @override
  State<StaffHomeScreen> createState() => _StaffHomeScreenState();
}

class _StaffHomeScreenState extends State<StaffHomeScreen> {
  List<Widget> pages = const [
    StaffHomePage(),
    StaffSearchPage(),
    StaffInviteVisitorPage(),
    StaffProfilePage(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WELCOME Staff Name'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StafNotificationScreen(),
                    ));
              },
              icon: const Icon(
                Icons.notifications_active_rounded,
                color: Colors.black,
              ))
        ],
      ),
      body: pages[currentIndex],
      drawer: MyDrawer(
        homeButtonTap: () {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, StaffHomeScreen.routeName);
        },
        logOutButtonTap: () {},
        profileButtonTap: () {},
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
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
    );
  }
}
