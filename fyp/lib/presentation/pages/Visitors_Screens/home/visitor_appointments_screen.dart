import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_qrcode_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_wait_screen.dart';

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
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VisitorWaitScreen(),
                      ));
                },
                child: card('Ameen Khowaja', 'Computer Science')),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VisitorQrcodeScreen(),
                      ));
                },
                child: card('Irfan Ali Kandhro', 'Computer Science')),
            card('Mansoor Ahmed Khuhro', 'Computer Science'),
            card('Addmission Department', 'Addmission Department'),
          ],
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
