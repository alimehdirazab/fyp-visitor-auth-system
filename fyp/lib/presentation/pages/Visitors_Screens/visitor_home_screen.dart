import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_form_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_qrcode_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_wait_screen.dart';

class VisitorHomeScreen extends StatelessWidget {
  const VisitorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const VisitorHomeScreen(),
            //     ));
          },
          icon: const Icon(Icons.home),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VisitorFormScreen(),
                  ));
            },
            icon: const Icon(
              Icons.add_circle_outline_rounded,
            ),
          ),
        ],
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
    );
  }
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
