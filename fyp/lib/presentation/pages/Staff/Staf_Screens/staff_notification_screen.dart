import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/widgets/notification_alert_box.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/widgets/notification_request_box.dart';

class StaffNotificationScreen extends StatefulWidget {
  const StaffNotificationScreen({super.key});
  static const String routeName = "staffNotificationScreen";

  @override
  State<StaffNotificationScreen> createState() =>
      _StaffNotificationScreenState();
}

class _StaffNotificationScreenState extends State<StaffNotificationScreen> {
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
                imageUrl: 'assets/images/ali_mehdi_raza.jpg',
                onTap: () {},
              ),
              NotificationRequestBox(
                text: "ALi want to meet you on Tuesday at 3:00 om",
                time: "12:10 pm",
                imageUrl: 'assets/images/ali_mehdi_raza.jpg',
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
