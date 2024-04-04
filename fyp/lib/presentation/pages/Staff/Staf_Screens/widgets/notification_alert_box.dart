import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';

class NotificationAlertBox extends StatelessWidget {
  final String text;
  final String time;
  final String imageUrl;
  final void Function()? onTap;
  const NotificationAlertBox({
    super.key,
    required this.text,
    required this.time,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      child: InkWell(
        hoverColor: Colors.grey[50],
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: Colors.grey.shade400,
            ),
          ),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 7),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.body2
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 13),
                    ),
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
