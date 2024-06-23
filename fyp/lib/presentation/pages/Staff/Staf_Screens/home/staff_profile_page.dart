import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/logic/services/staff_preferences.dart';
import 'package:fyp/presentation/pages/LoadingScreens/visitor_loading_screen.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';
import 'package:fyp/presentation/widgets/profile_tile.dart';

class StaffProfilePage extends StatefulWidget {
  const StaffProfilePage({super.key});

  @override
  State<StaffProfilePage> createState() => _StaffProfilePageState();
}

class _StaffProfilePageState extends State<StaffProfilePage> {
  String? _name;
  String? _email;
  String? _role;
  String? _profilePic;
  String? _password;

  @override
  void initState() {
    super.initState();
    _loadStaffDetails();
  }

  Future<void> _loadStaffDetails() async {
    final staffDetails = await StaffPreferences.fetchStaffDetails();
    setState(() {
      _name = staffDetails['name'];
      _email = staffDetails['email'];
      _role = staffDetails['role'];
      _profilePic = staffDetails['profilePic'];
      _password = staffDetails['password'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 3, bottom: 3),
                    child: ClipOval(
                      child: _profilePic != null
                          ? CachedNetworkImage(
                              imageUrl: _profilePic!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.person, size: 120),
                            )
                          : const Icon(
                              Icons.person,
                              size: 120,
                            ),
                    ),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        // Handle profile picture change
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                      ),
                    ),
                  ),
                ],
              ),
              const GapWidget(size: 20),
              ProfileTile(
                leadingIcon: Icons.person,
                title: 'Name',
                subtitle: _name ?? 'Loading...',
              ),
              ProfileTile(
                leadingIcon: Icons.email_outlined,
                title: 'Email',
                subtitle: _email ?? 'Loading...',
              ),
              ProfileTile(
                leadingIcon: Icons.person_pin_outlined,
                title: 'Designation',
                subtitle: _role ?? 'Loading...',
              ),
              ProfileTile(
                leadingIcon: Icons.lock,
                title: 'Password',
                subtitle: _password != null ? '*********' : 'Loading...',
              ),
              const GapWidget(size: 20),
              PrimaryButton(
                onPressed: () {
                  BlocProvider.of<StaffCubit>(context).signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacementNamed(
                      context, VisitorLoadingScreen.routeName);
                },
                text: "Log out",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
