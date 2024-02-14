import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_home_page.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_profile_page.dart';
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
    StaffProfilePage(),
    StaffProfilePage(),
    StaffProfilePage(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade100,
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
                text: "Log",
              ),
              GButton(
                icon: Icons.insert_invitation,
                text: "Invites",
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
