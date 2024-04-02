import 'package:flutter/material.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/meeting_card.dart';
import 'package:fyp/presentation/widgets/search_textfield.dart';

class StaffSearchPage extends StatefulWidget {
  const StaffSearchPage({super.key});

  @override
  State<StaffSearchPage> createState() => _StaffSearchPageState();
}

class _StaffSearchPageState extends State<StaffSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SearchTextField(),
            const GapWidget(size: 10),
            MeetingCard(
              name: 'Ali Mehdi Raza',
              subTitle: 'For Fyp Meeting',
              time: '10:20 Am',
              date: '07/04/2024',
              day: 'SATURDAY',
              status: 'Pending',
              onTap: () {},
            ),
            const GapWidget(size: -8),
            MeetingCard(
              name: 'Elon Musk',
              subTitle: 'Meeting For StarLink New Project',
              time: '10:20 Am',
              date: '09/04/2024',
              day: 'Monday',
              status: 'Cancel',
              onTap: () {},
            ),
            const GapWidget(size: -8),
            MeetingCard(
              name: 'Bilal Khatri',
              subTitle: 'For Meeting',
              time: '11:00 Am',
              date: '07/04/2024',
              day: 'SATURDAY',
              status: 'Visited',
              onTap: () {},
            ),
            const GapWidget(size: -8),
            MeetingCard(
              name: 'Ali Mehdi Raza',
              subTitle: 'For Fyp Meeting',
              time: '10:20 Am',
              date: '07/04/2024',
              day: 'SATURDAY',
              status: 'Pending',
              onTap: () {},
            ),
            const GapWidget(size: -8),
            MeetingCard(
              name: 'Elon Musk',
              subTitle: 'Meeting For StarLink New Project',
              time: '10:20 Am',
              date: '09/04/2024',
              day: 'Monday',
              status: 'Cancel',
              onTap: () {},
            ),
            const GapWidget(size: -8),
            MeetingCard(
              name: 'Bilal Khatri',
              subTitle: 'For Meeting',
              time: '11:00 Am',
              date: '07/04/2024',
              day: 'SATURDAY',
              status: 'Visited',
              onTap: () {},
            ),
          ],
        ),
      ),
    ));
  }
}
