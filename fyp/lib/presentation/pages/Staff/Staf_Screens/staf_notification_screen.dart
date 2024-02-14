import 'package:flutter/material.dart';
import 'package:fyp/main.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_home_screen.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/widgets/notification_alert_box.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/widgets/notification_request_box.dart';

class StafNotificationScreen extends StatelessWidget {
  const StafNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              NotificationAlertBox(
                text: "visitor Bilal Ahmed Enterd in University",
                time: "9:45 am",
                onTap: () {},
              ),
              NotificationRequestBox(
                text: "ALi want to meet you on Tuesday at 3:00 om",
                time: "12:10 pm",
                onNotificationTap: () {},
                acceptButtonPressed: () {},
                rejectButtonPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
