import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_home_page.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_profile_page.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_red_list_page.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_scan_visitor_page.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_search_page.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/staff_notification_screen.dart';

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
    SecuritySearchPage(),
    SecurityRedListPage(),
    SecurityProfilePage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = const SecurityHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Security Home Screen'),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.pushNamed(context, StaffNotificationScreen.routeName);
        //       },
        //       icon: const Icon(
        //         Icons.published_with_changes_outlined,
        //         color: Colors.black,
        //       )),
        //   IconButton(
        //       onPressed: () {
        //         Navigator.pushNamed(context, StaffNotificationScreen.routeName);
        //       },
        //       icon: const Icon(
        //         Icons.notifications_active_rounded,
        //         color: Colors.black,
        //       )),
        // ],
      ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecurityScanVisitorPage(),
              ));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.qr_code_scanner),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = pages[0];
                        _selectedIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: _selectedIndex == 0
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                        ),
                        // Icon
                        Text(
                          'Home',
                          style: TextStyle(
                            color: _selectedIndex == 0
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                        ),
                        // Text
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = pages[1];
                        _selectedIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: _selectedIndex == 1
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                        ),
                        // Icon
                        Text(
                          'Search',
                          style: TextStyle(
                            color: _selectedIndex == 1
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                        ),
                        // Text
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = pages[2];
                        _selectedIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_off_rounded,
                          color: _selectedIndex == 3
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                        ),
                        // Icon
                        Text(
                          'Red List',
                          style: TextStyle(
                            color: _selectedIndex == 3
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                        ),
                        // Text
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = pages[3];
                        _selectedIndex = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: _selectedIndex == 4
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                        ),
                        // Icon
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: _selectedIndex == 4
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                        ),
                        // Text
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
