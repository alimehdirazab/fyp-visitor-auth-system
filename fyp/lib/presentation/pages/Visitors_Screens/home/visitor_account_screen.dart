import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';
import 'package:fyp/logic/services/location_service.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/logic/services/visitor_preferences.dart';
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
  String? name;
  String? email;
  String? phone;
  String? profilePicture;

  @override
  void initState() {
    super.initState();
    _fetchVisitorDetails();
  }

  static Future<List<AppointmentDataModel>>
      getAppointmentsWithStatusEntered() async {
    try {
      print(
          'Fetching appointments with status "entered", "running", or "redListed"');
      final visitorCubit = VisitorCubitSingleton.getInstance();
      await visitorCubit.fetchAppointments();
      final state = visitorCubit.state;

      if (state is VisitorAppointmentFetchLoadedState) {
        print('Appointments fetched successfully');
        return state.appointmentData.where((appointment) {
          return appointment.status == 'entered' ||
              appointment.status == 'running' ||
              appointment.status == 'redListed';
        }).toList();
      } else {
        print('Failed to fetch appointments or no appointments found');
        return [];
      }
    } catch (e) {
      print('Error fetching appointments: $e');
      return [];
    }
  }

  Future<void> _fetchVisitorDetails() async {
    final details = await VisitorPreferences.fetchVisitorDetails();
    setState(() {
      name = details['visitorName'];
      email = details['email'];
      phone = details['phoneNumber'];
      profilePicture = details['profilePicture'];
    });
  }

  static Future<bool> canLogout() async {
    // Fetch appointments with status "entered", "running", or "redListed"
    final appointments = await getAppointmentsWithStatusEntered();
    return appointments.isEmpty;
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
                      child: profilePicture != null
                          ? CachedNetworkImage(
                              imageUrl: profilePicture!,
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
                      onPressed: () {},
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
                subtitle: name ?? 'Add your name',
              ),
              ProfileTile(
                leadingIcon: Icons.email_outlined,
                title: 'Email',
                subtitle: email ?? 'Add your email',
              ),
              ProfileTile(
                leadingIcon: Icons.phone,
                title: 'Phone',
                subtitle: phone ?? 'Add your phone number',
              ),
              const ProfileTile(
                leadingIcon: Icons.lock,
                title: 'Password',
                subtitle: '*********',
              ),
              const GapWidget(size: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: PrimaryButton(
                  onPressed: () async {
                    if (await canLogout()) {
                      BlocProvider.of<VisitorCubit>(context).signOut();
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacementNamed(
                          context, VisitorLoadingScreen.routeName);
                    } else {
                      // Show warning dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Logout Restricted'),
                          content: const Text(
                              'You cannot logout while an appointment is in progress.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  text: "Log out",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
