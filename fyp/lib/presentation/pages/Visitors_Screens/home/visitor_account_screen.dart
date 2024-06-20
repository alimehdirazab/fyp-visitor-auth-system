import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/presentation/pages/LoadingScreens/visitor_loading_screen.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';
import 'package:fyp/presentation/widgets/profile_tile.dart';

class VisitorAccountScreen extends StatefulWidget {
  const VisitorAccountScreen({super.key});

  @override
  State<VisitorAccountScreen> createState() => _VisitorAccountScreenState();
}

class _VisitorAccountScreenState extends State<VisitorAccountScreen> {
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
                  BlocProvider.of<VisitorCubit>(context).signOut();
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
