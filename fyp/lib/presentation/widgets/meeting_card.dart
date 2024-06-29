import 'package:flutter/material.dart';

class MeetingCard extends StatelessWidget {
  final String? name;
  final String subTitle;
  final String? status;
  final String time;
  final String date;
  final String day;
  final void Function()? onTap;

  const MeetingCard({
    Key? key,
    required this.name,
    required this.subTitle,
    this.status,
    required this.time,
    required this.date,
    required this.day,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.black;

    if (status == 'accepted') {
      statusColor = const Color(0xFF5A9F68); // accepted color
    } else if (status == 'pending') {
      statusColor = const Color(0xFFFF9900); // pending color
    } else if (status == 'rejected') {
      statusColor = const Color(0xFFFF0000); // rejected color
    } else if (status == 'entered') {
      statusColor = Colors.blue; // entered color
    }

    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.grey.shade400,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name!,
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subTitle,
                      style: const TextStyle(fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$date $time'),
                  Text(day),
                  Text(
                    status ?? '',
                    style: TextStyle(color: statusColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
