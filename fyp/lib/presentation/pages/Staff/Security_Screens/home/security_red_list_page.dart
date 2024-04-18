import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/meeting_card.dart';

class SecurityRedListPage extends StatefulWidget {
  const SecurityRedListPage({super.key});

  @override
  State<SecurityRedListPage> createState() => _SecurityRedListPageState();
}

class _SecurityRedListPageState extends State<SecurityRedListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              MeetingCard(
                name: 'Ali Mehdi Raza',
                subTitle: 'For Fyp Meeting',
                time: '10:20 Am',
                date: '07/04/2024',
                day: 'SATURDAY',
                status: 'Cancel',
                onTap: () {},
              ),
              const GapWidget(size: -8),
              MeetingCard(
                name: 'Ali Mehdi Raza',
                subTitle: 'For Fyp Meeting',
                time: '10:20 Am',
                date: '07/04/2024',
                day: 'SATURDAY',
                status: 'Cancel',
                onTap: () {},
              ),
              const GapWidget(size: -8),
              MeetingCard(
                name: 'Ali Mehdi Raza',
                subTitle: 'For Fyp Meeting',
                time: '10:20 Am',
                date: '07/04/2024',
                day: 'SATURDAY',
                status: 'Cancel',
                onTap: () {},
              ),
              const GapWidget(size: -8),
              MeetingCard(
                name: 'Ali Mehdi Raza',
                subTitle: 'For Fyp Meeting',
                time: '10:20 Am',
                date: '07/04/2024',
                day: 'SATURDAY',
                status: 'Cancel',
                onTap: () {},
              ),
              const GapWidget(size: -8),
              MeetingCard(
                name: 'Ali Mehdi Raza',
                subTitle: 'For Fyp Meeting',
                time: '10:20 Am',
                date: '07/04/2024',
                day: 'SATURDAY',
                status: 'Cancel',
                onTap: () {},
              ),
              const GapWidget(size: -8),
              MeetingCard(
                name: 'Ali Mehdi Raza',
                subTitle: 'For Fyp Meeting',
                time: '10:20 Am',
                date: '07/04/2024',
                day: 'SATURDAY',
                status: 'Cancel',
                onTap: () {},
              ),
              const GapWidget(size: -8),
            ],
          ),
        ),
      ),
    );
  }
}
