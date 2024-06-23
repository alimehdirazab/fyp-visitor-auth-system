import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_state.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/meeting_card.dart';
import 'package:fyp/presentation/widgets/search_textfield.dart';
import 'package:intl/intl.dart';

class StaffSearchPage extends StatefulWidget {
  const StaffSearchPage({super.key});

  @override
  State<StaffSearchPage> createState() => _StaffSearchPageState();
}

class _StaffSearchPageState extends State<StaffSearchPage> {
  List<AppointmentDataModel> allAppointments = [];
  List<AppointmentDataModel> filteredAppointments = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StaffCubit>(context).fetchAppointments();
  }

  void _filterAppointments(String query) {
    setState(() {
      searchQuery = query;
      filteredAppointments = allAppointments
          .where((appointment) =>
              appointment.visitor.name
                  ?.toLowerCase()
                  .contains(query.toLowerCase()) ??
              false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SearchTextField(onChanged: _filterAppointments),
              const GapWidget(size: 10),
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
                  allAppointments = state.appointmentData;
                  if (searchQuery.isEmpty) {
                    filteredAppointments = allAppointments;
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredAppointments.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final appointment = filteredAppointments[index];
                      final scheduleDate = DateFormat('yyyy-MM-dd')
                          .format(appointment.scheduleDate);
                      final scheduleTime =
                          DateFormat('HH:mm').format(appointment.scheduleTime);
                      final day =
                          DateFormat('EEEE').format(appointment.scheduleDate);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
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
            ],
          ),
        ),
      ),
    );
  }
}
