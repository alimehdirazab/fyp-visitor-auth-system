import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_qrcode_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_wait_screen.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/meeting_card.dart';

class VisitorAppointmentsScreen extends StatefulWidget {
  const VisitorAppointmentsScreen({super.key});

  @override
  State<VisitorAppointmentsScreen> createState() =>
      _VisitorAppointmentsScreenState();
}

class _VisitorAppointmentsScreenState extends State<VisitorAppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Appointments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              MeetingCard(
                  name: 'Mansoor Ahmed Khuhro',
                  subTitle: 'Computer Science',
                  date: '13/4/2024',
                  day: 'Wednesday',
                  time: '10:30 Am',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VisitorWaitScreen(),
                        ));
                  }),
              const GapWidget(size: -8),
              MeetingCard(
                name: 'Addmission Department',
                subTitle: 'Addmission Department',
                date: '13/4/2024',
                day: 'Wednesday',
                time: '10:30 Am',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VisitorQrcodeScreen(),
                      ));
                },
              ),
              const GapWidget(size: -8),
              const MeetingCard(
                name: 'Asif Ali Wagan',
                subTitle: 'Computer Science',
                date: '13/4/2024',
                day: 'Wednesday',
                time: '10:30 Am',
              )
            ],
          ),
        ),
      ),
      //bottomNavigationBar: Bottom,
    );
  }

  Widget card(String name, String department) {
    return Card(
      color: const Color.fromARGB(230, 255, 255, 255),
      elevation: 1,
      child: ListTile(
        title: Text(name),
        subtitle: Text(department),
        trailing: const Text('10:30 \nWednesday'),
      ),
    );
  }
}
