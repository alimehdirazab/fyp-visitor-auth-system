import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_state.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/staff_visitor_details_screen.dart';
import 'package:fyp/presentation/widgets/custom_dropdown_button.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/meeting_card.dart';

import 'package:fyp/presentation/widgets/total_value_card.dart';
import 'package:intl/intl.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({super.key});

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  late Size mq = MediaQuery.of(context).size;
  List<String> filters = ['Today', 'This Week', 'This Month'];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StaffCubit>(context).fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TotalValueCard(
                        total: 19,
                        value: 'Visitors Expacted',
                        color: Color(0XFFB4DBFF),
                        image: 'assets/images/m1.png',
                      ),
                      TotalValueCard(
                          total: 13,
                          value: 'Completed Meetings',
                          color: Color(0XFFD1FFDB),
                          image: 'assets/images/m2.png'),
                    ],
                  ),
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TotalValueCard(
                          total: 3,
                          value: 'Cancel Meetings',
                          color: Color(0XFFFFC5C5),
                          image: 'assets/images/m3.png'),
                      TotalValueCard(
                          total: 4,
                          value: 'Pending Meetings ',
                          color: Color(0XFFFFDEAC),
                          image: 'assets/images/m4.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Meetings', style: TextStyles.heading3),
                        CustomDropdownButton(items: filters),
                      ],
                    ),
                    BlocBuilder<StaffCubit, StaffState>(
                        builder: (context, state) {
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
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.appointmentData.length,
                          itemBuilder: (context, index) {
                            final appointment = state.appointmentData[index];
                            final scheduleDate = DateFormat('yyyy-MM-dd')
                                .format(appointment.scheduleDate);
                            final scheduleTime = DateFormat('HH:mm')
                                .format(appointment.scheduleTime);
                            final day = DateFormat('EEEE').format(appointment
                                .scheduleDate); // Getting the day name

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: MeetingCard(
                                name: appointment.visitor.name ?? 'N/A',
                                subTitle: appointment.reason,
                                date: scheduleDate,
                                day: day,
                                time: scheduleTime,
                                status: appointment.status,
                                onTap: () {},
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                    const GapWidget(size: -8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
