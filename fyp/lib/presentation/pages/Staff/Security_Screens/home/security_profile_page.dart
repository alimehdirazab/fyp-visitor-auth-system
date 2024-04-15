import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/presentation/pages/loading_screen.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';
import 'package:fyp/presentation/widgets/profile_tile.dart';

class SecurityProfilePage extends StatefulWidget {
  const SecurityProfilePage({super.key});

  @override
  State<SecurityProfilePage> createState() => _SecurityProfilePageState();
}

class _SecurityProfilePageState extends State<SecurityProfilePage> {
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
                      child: Image.asset(
                        'assets/images/ali_mehdi_raza.jpg',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt,
                      ),
                    ),
                  ),
                ],
              ),
              const GapWidget(size: 20),
              const ProfileTile(
                leadingIcon: Icons.person,
                title: 'Name',
                subtitle: 'Ali Mehdi Raza',
              ),
              const ProfileTile(
                leadingIcon: Icons.email_outlined,
                title: 'Email',
                subtitle: 'alimehdirazab@gmail.com',
              ),
              const ProfileTile(
                leadingIcon: Icons.phone,
                title: 'Phone',
                subtitle: '+92 307 3064292',
              ),
              const ProfileTile(
                leadingIcon: Icons.lock,
                title: 'Password',
                subtitle: '*********',
              ),
              const GapWidget(size: 20),
              PrimaryButton(
                onPressed: () {
                  BlocProvider.of<StaffCubit>(context).signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacementNamed(
                      context, LoadingScreen.routeName);
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
