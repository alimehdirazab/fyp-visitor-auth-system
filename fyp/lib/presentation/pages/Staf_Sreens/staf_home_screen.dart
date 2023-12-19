import 'package:flutter/material.dart';
import 'package:fyp/main.dart';
import 'package:fyp/presentation/pages/Staf_Sreens/staf_notification_screen.dart';

class StafHomeScreen extends StatelessWidget {
  const StafHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meetings'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StafNotificationScreen(),
                    ));
              },
              icon: const Icon(
                Icons.notifications_active_rounded,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: mq.width * 0.70,
                    child: const TextField(
                      decoration: InputDecoration(hintText: "Search here..."),
                    )),
                IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt))
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  card('Ali Mehdi Raza', 'For Fyp Meeting', 'pending'),
                  card('Elon Musk', 'Meeting For StarLink New Project',
                      'pending'),
                  card('Bilal Khatri', 'For Meeting', 'Visited'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget card(String name, String reason, String status) {
    return Card(
      color: const Color.fromARGB(230, 255, 255, 255),
      elevation: 1,
      child: ListTile(
        title: Text(name),
        subtitle: Text(reason),
        trailing: Column(
          children: [
            const Text('10:30 \nWednesday'),
            Text(status,
                style: TextStyle(
                    color: status == 'pending' ? Colors.red : Colors.green))
          ],
        ),
      ),
    );
  }
}
