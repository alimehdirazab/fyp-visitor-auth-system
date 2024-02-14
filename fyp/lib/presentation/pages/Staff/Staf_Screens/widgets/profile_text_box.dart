import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';

class ProfileTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  const ProfileTextBox(
      {super.key, required this.sectionName, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sectionName,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            Text(
              text,
              style: TextStyles.body1,
            ),
          ],
        ),
      ),
    );
  }
}
