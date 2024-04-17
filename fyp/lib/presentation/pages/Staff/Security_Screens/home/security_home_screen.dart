import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_exchange_duty_page.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_home_page.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_profile_page.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_scan_visitor_page.dart';

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
    SecurtiyScanVisitorPage(),
    SecurityProfilePage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = const SecurityHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Home Screen'),
      ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your functionality here
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
                        currentScreen = const SecurityHomePage();
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
                        currentScreen = const SecurityExchangeDutyPage();
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
                        currentScreen = const SecurityHomePage();
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
                        currentScreen = const SecurityExchangeDutyPage();
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
