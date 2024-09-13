import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_home_page.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_invite_visitor_page.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_profile_page.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_search_page.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/widgets/my_drawer.dart';

class StaffHomeScreen extends StatefulWidget {
  const StaffHomeScreen({super.key});
  static const String routeName = "staffHomeScreen";
  @override
  State<StaffHomeScreen> createState() => _StaffHomeScreenState();
}

class _StaffHomeScreenState extends State<StaffHomeScreen> {
  final PageStorageBucket _bucket = PageStorageBucket();
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
        title: Text(
          'WELCOME STAFF',
          style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.pushNamed(context, StaffNotificationScreen.routeName);
        //       },
        //       icon: const Icon(
        //         Icons.notifications_active_rounded,
        //         color: Colors.black,
        //       ))
        // ],
      ),
      body: PageStorage(
        bucket: _bucket,
        child: SafeArea(child: pages[currentIndex]),
      ),
      drawer: MyDrawer(
        homeButtonTap: () {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, StaffHomeScreen.routeName);
        },
        logOutButtonTap: () {},
        profileButtonTap: () {},
      ),
      bottomNavigationBar: BottomNavigationBar(
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
