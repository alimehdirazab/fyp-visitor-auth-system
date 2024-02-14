import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';

class NotificationAlertBox extends StatelessWidget {
  final String text;
  final String time;
  const NotificationAlertBox(
      {super.key, required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.person)),
            const SizedBox(width: 3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.body2),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
