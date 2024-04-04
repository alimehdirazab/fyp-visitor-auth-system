import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';

class NotificationRequestBox extends StatelessWidget {
  final String text;
  final String time;
  final String imageUrl;
  final void Function()? onNotificationTap;
  final void Function()? acceptButtonPressed;
  final void Function()? rejectButtonPressed;

  const NotificationRequestBox({
    Key? key,
    required this.text,
    required this.time,
    required this.imageUrl,
    required this.onNotificationTap,
    required this.acceptButtonPressed,
    required this.rejectButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        hoverColor: Colors.grey[50],
        onTap: onNotificationTap,
        child: Ink(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: Colors.grey.shade400,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Aligns icon buttons to the right
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.body2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        time,
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: acceptButtonPressed,
                  icon: const Icon(Icons.done),
                ),
                IconButton(
                  onPressed: rejectButtonPressed,
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
