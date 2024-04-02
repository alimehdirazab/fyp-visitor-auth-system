import 'package:flutter/material.dart';

class MeetingCard extends StatelessWidget {
  final String name;
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

    if (status == 'Visited') {
      statusColor = const Color(0xFF5A9F68); // Visited color
    } else if (status == 'Pending') {
      statusColor = const Color(0xFFFF9900); // Pending color
    } else if (status == 'Cancel') {
      statusColor = const Color(0xFFFF0000); // Cancel color
    }

    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: Colors.grey.shade400,
            ),
          ),
          child: ListTile(
            title: Text(
              name,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              subTitle,
              style: const TextStyle(fontSize: 11),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(' $date   $time'),
                Text(day),
                Text(
                  status ?? '',
                  style: TextStyle(color: statusColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
