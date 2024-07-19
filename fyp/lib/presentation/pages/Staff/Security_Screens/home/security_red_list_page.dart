import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_state.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/others/security_visitor_details_page.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/meeting_card.dart';
import 'package:intl/intl.dart';

class SecurityRedListPage extends StatefulWidget {
  const SecurityRedListPage({super.key});

  @override
  State<SecurityRedListPage> createState() => _SecurityRedListPageState();
}

class _SecurityRedListPageState extends State<SecurityRedListPage> {
  List<AppointmentDataModel> redListedAppointments = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StaffCubit>(context).fetchAllAppointments();
  }

  void _filterRedListedAppointments(List<AppointmentDataModel> appointments) {
    redListedAppointments = appointments
        .where((appointment) => appointment.status == 'redListed')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Red Listed Meetings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              BlocBuilder<StaffCubit, StaffState>(builder: (context, state) {
                if (state is StaffAppointmentFetchLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is StaffAppointmentFetchErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is StaffAppointmentFetchLoadedState) {
                  _filterRedListedAppointments(state.appointmentData);
                  return Column(
                    children: redListedAppointments.map((appointment) {
                      final scheduleDate = DateFormat('yyyy-MM-dd')
                          .format(appointment.scheduleDate);
                      final scheduleTime =
                          DateFormat('HH:mm').format(appointment.scheduleTime);
                      final day = DateFormat('EEEE').format(
                          appointment.scheduleDate); // Getting the day name

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: MeetingCard(
                          name: appointment.visitor.name ?? 'N/A',
                          subTitle: appointment.user.name ?? 'N/A',
                          date: scheduleDate,
                          day: day,
                          time: scheduleTime,
                          status: appointment.status,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SecurityVisitorDetailsPage(
                                  id: appointment.id,
                                  name: appointment.visitor.name ?? 'N/A',
                                  email: appointment.visitor.email,
                                  phone: appointment.visitor.phone ?? 'N/A',
                                  profilePic:
                                      appointment.visitor.profilePic ?? 'N/A',
                                  cnicFrontPic:
                                      appointment.visitor.cnicFrontPic ?? 'N/A',
                                  cnicBackPic:
                                      appointment.visitor.cnicBackPic ?? 'N/A',
                                  mapTrackings: appointment.mapTrackings,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
              const GapWidget(size: -8),
            ],
          ),
        ),
      ),
    );
  }
}
