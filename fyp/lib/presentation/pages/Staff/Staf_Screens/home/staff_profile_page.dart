import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/widgets/profile_text_box.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';

class StaffProfilePage extends StatefulWidget {
  const StaffProfilePage({super.key});

  @override
  State<StaffProfilePage> createState() => _StaffProfilePageState();
}

class _StaffProfilePageState extends State<StaffProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        children: [
          const GapWidget(),
          const Icon(Icons.person, size: 65),
          Text('Ali Mehdi Raza',
              style: TextStyles.heading3, textAlign: TextAlign.center),
          const GapWidget(),
          Text(
            'My Details',
            style: TextStyles.heading3.copyWith(fontWeight: FontWeight.normal),
          ),
          const ProfileTextBox(sectionName: "Name", text: "Ali Mehdi Raza"),
          const ProfileTextBox(
              sectionName: "Email", text: "alimehdiraza@gmail.com"),
          const ProfileTextBox(sectionName: "Phone", text: "03073064292"),
          const ProfileTextBox(
              sectionName: "Profile Type", text: "Staff Profile"),
          Text(
            'Account Menu',
            style: TextStyles.heading3.copyWith(fontWeight: FontWeight.normal),
          ),
          const GapWidget(),
          PrimaryButton(text: "Profile Settings", onPressed: () {}),
          const GapWidget(),
          PrimaryButton(text: "Logout", onPressed: () {})
        ],
      ),
    );
  }
}
