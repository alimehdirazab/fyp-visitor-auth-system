import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_state.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/others/security_visitor_details_page.dart';
import 'package:fyp/presentation/widgets/custom_dropdown_button.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/meeting_card.dart';
import 'package:fyp/presentation/widgets/total_value_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SecurityHomePage extends StatefulWidget {
  const SecurityHomePage({super.key});

  @override
  State<SecurityHomePage> createState() => _SecurityHomePageState();
}

class _SecurityHomePageState extends State<SecurityHomePage> {
  late Size mq = MediaQuery.of(context).size;
  List<String> filters = ['All', 'Today', 'This Week', 'This Month'];
  int visitorsExpected = 0;
  int enteredInUniversity = 0;
  int exitFromUniversity = 0;
  int inUniversity = 0;
  String selectedFilter = 'Today';
  List<AppointmentDataModel> filteredAppointments = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StaffCubit>(context).fetchAllAppointments();
  }

  void _calculateCounts(List<AppointmentDataModel> appointments) {
    final now = DateTime.now();
    DateTime startDate;
    DateTime endDate;

    if (selectedFilter == 'Today') {
      startDate = DateTime(now.year, now.month, now.day);
      endDate = startDate.add(const Duration(days: 1));
    } else if (selectedFilter == 'This Week') {
      startDate = now.subtract(Duration(days: now.weekday - 1));
      endDate = startDate.add(const Duration(days: 7));
    } else if (selectedFilter == 'This Month') {
      startDate = DateTime(now.year, now.month, 1);
      endDate = DateTime(now.year, now.month + 1, 1);
    } else {
      startDate = DateTime(1900); // Arbitrary early date
      endDate = DateTime(2100); // Arbitrary future date
    }

    filteredAppointments = appointments.where((appointment) {
      return appointment.scheduleDate.isAfter(startDate) &&
          appointment.scheduleDate.isBefore(endDate);
    }).toList();

    visitorsExpected = filteredAppointments
        .where((appointment) => appointment.status == 'accepted')
        .length;
    enteredInUniversity = filteredAppointments
        .where((appointment) => appointment.status == 'entered')
        .length;
    exitFromUniversity = filteredAppointments
        .where((appointment) => appointment.status == 'out')
        .length;
    inUniversity = enteredInUniversity - exitFromUniversity;
  }

  void _onFilterChanged(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                _calculateCounts(state.appointmentData);
                return Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TotalValueCard(
                            total: visitorsExpected,
                            value: 'Expected Visitors',
                            color: const Color(0XFFB4DBFF),
                            image: 'assets/images/m1.png',
                          ),
                          TotalValueCard(
                              total: enteredInUniversity,
                              value: 'Entered In University',
                              color: const Color(0XFFD1FFDB),
                              image: 'assets/images/m5.png'),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TotalValueCard(
                              total: exitFromUniversity,
                              value: 'Exit From University',
                              color: const Color(0XFFFFC5C5),
                              image: 'assets/images/m2.png'),
                          TotalValueCard(
                              total: inUniversity,
                              value: 'In University',
                              color: const Color(0XFFFFDEAC),
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
                            CustomDropdownButton(
                              items: filters,
                              selectedValue: selectedFilter,
                              onChanged: _onFilterChanged,
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredAppointments.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final appointment = filteredAppointments[index];
                            final scheduleDate = DateFormat('yyyy-MM-dd')
                                .format(appointment.scheduleDate);
                            final scheduleTime = DateFormat('HH:mm')
                                .format(appointment.scheduleTime);
                            final day = DateFormat('EEEE').format(appointment
                                .scheduleDate); // Getting the day name

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
                                                name:
                                                    appointment.visitor.name ??
                                                        'N/A',
                                                email:
                                                    appointment.visitor.email,
                                                phone:
                                                    appointment.visitor.phone ??
                                                        'N/A',
                                                profilePic: appointment
                                                        .visitor.profilePic ??
                                                    'N/A',
                                                cnicFrontPic: appointment
                                                        .visitor.cnicFrontPic ??
                                                    'N/A',
                                                cnicBackPic: appointment
                                                        .visitor.cnicBackPic ??
                                                    'N/A',
                                                mapTrackings:
                                                    appointment.mapTrackings,
                                              )));
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
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
    );
  }
}
