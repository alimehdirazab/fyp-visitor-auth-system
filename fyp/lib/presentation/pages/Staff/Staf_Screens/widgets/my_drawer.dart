import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/widgets/drawer_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? homeButtonTap;
  final void Function()? profileButtonTap;
  final void Function()? logOutButtonTap;
  const MyDrawer(
      {super.key,
      required this.profileButtonTap,
      required this.homeButtonTap,
      required this.logOutButtonTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const DrawerHeader(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 65,
                  ),
                ),
                DrawerListTile(
                  icon: Icons.home,
                  text: "H O M E",
                  onTap: () => Navigator.pop(context),
                ),
                DrawerListTile(
                  icon: Icons.person,
                  text: "P R O F I L E",
                  onTap: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: DrawerListTile(
                icon: Icons.logout,
                text: "L O G O U T",
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
