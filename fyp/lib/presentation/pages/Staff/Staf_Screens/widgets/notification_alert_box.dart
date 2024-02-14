import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';

class NotificationAlertBox extends StatelessWidget {
  final String text;
  final String time;
  final void Function()? onTap;
  const NotificationAlertBox(
      {super.key, required this.text, required this.time, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        hoverColor: Colors.grey[50],
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const CircleAvatar(child: Icon(Icons.person)),
              const SizedBox(width: 5),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.body2),
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
