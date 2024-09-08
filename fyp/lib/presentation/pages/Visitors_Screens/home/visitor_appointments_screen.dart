import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_qrcode_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_wait_screen.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/meeting_card.dart';
import 'package:intl/intl.dart';

class VisitorAppointmentsScreen extends StatefulWidget {
  const VisitorAppointmentsScreen({super.key});

  @override
  State<VisitorAppointmentsScreen> createState() =>
      _VisitorAppointmentsScreenState();
}

class _VisitorAppointmentsScreenState extends State<VisitorAppointmentsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VisitorCubit>(context).fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('All Appointments'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<VisitorCubit, VisitorState>(
              builder: (context, state) {
            if (state is VisitorAppointmentFetchLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is VisitorAppointmentFetchErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is VisitorAppointmentFetchLoadedState) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.appointmentData.length,
                itemBuilder: (context, index) {
                  final appointment = state.appointmentData[index];
                  final scheduleDate =
                      DateFormat('yyyy-MM-dd').format(appointment.scheduleDate);
                  final scheduleTime =
                      DateFormat('HH:mm').format(appointment.scheduleTime);
                  final day = DateFormat('EEEE')
                      .format(appointment.scheduleDate); // Getting the day name

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: MeetingCard(
                      name: appointment.user.name ?? 'N/A',
                      subTitle: appointment.reason,
                      date: scheduleDate,
                      day: day,
                      time: scheduleTime,
                      status: appointment.status,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => appointment.qrToken == null
                                ? const VisitorWaitScreen()
                                : VisitorQrcodeScreen(
                                    qrToken: appointment.qrToken,
                                    visitorName: appointment.visitor.name ??
                                        'Unknown Visitor',
                                    visitorProfilePicture:
                                        appointment.visitor.profilePic,
                                  ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
        //bottomNavigationBar: Bottom,
      );
    });
  }
}
