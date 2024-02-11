import 'package:flutter/material.dart';
import 'package:fyp/main.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_home_screen.dart';

class StafNotificationScreen extends StatelessWidget {
  const StafNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StaffHomeScreen(),
                    ));
              },
              icon: const Icon(
                Icons.home,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              card('Ali Mehdi Raza', 'For Fyp Meeting'),
              card('Elon Musk', 'Meeting For StarLink New Project'),
              card('Bilal Khatri', 'For Meeting'),
            ],
          ),
        ),
      ),
    );
  }

  Widget card(String name, String reason) {
    return SizedBox(
      // height: mq.height / 5,
      child: Card(
        color: const Color.fromARGB(230, 255, 255, 255),
        elevation: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(name),
                Text(reason),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                button('Accept', const Color.fromARGB(255, 89, 172, 91)),
                // const SizedBox(height: 5),
                button('Reject ', const Color.fromARGB(255, 175, 73, 66)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget button(String name, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: color, minimumSize: const Size(60, 14)),
      child: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
