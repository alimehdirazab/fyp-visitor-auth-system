import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/presentation/widgets/custom_dropdown_button.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/meeting_card.dart';
import 'package:fyp/presentation/widgets/total_value_card.dart';

class SecurityHomePage extends StatefulWidget {
  const SecurityHomePage({super.key});

  @override
  State<SecurityHomePage> createState() => _SecurityHomePageState();
}

class _SecurityHomePageState extends State<SecurityHomePage> {
  late Size mq = MediaQuery.of(context).size;
  List<String> filters = ['Today', 'This Week', 'This Month'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TotalValueCard(
                    total: 19,
                    value: 'Visitors Expacted',
                    color: Color(0XFFB4DBFF),
                    image: 'assets/images/m1.png',
                  ),
                  TotalValueCard(
                      total: 13,
                      value: 'Completed Meetings',
                      color: Color(0XFFD1FFDB),
                      image: 'assets/images/m2.png'),
                ],
              ),
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TotalValueCard(
                      total: 3,
                      value: 'Cancel Meetings',
                      color: Color(0XFFFFC5C5),
                      image: 'assets/images/m3.png'),
                  TotalValueCard(
                      total: 4,
                      value: 'Pending Meetings ',
                      color: Color(0XFFFFDEAC),
                      image: 'assets/images/m4.png'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Meetings', style: TextStyles.heading3),
                    CustomDropdownButton(items: filters),
                  ],
                ),
                // MeetingCard(
                //   name: 'Ali Mehdi Raza',
                //   subTitle: 'For Fyp Meeting',
                //   time: '10:20 Am',
                //   date: '07/04/2024',
                //   day: 'SATURDAY',
                //   status: 'Pending',
                //   onTap: () {
                //     // Navigator.pushNamed(
                //     //     context, StaffVisitorDetailsScreen.routeName);
                //   },
                // ),
                // const GapWidget(size: -8),
                // MeetingCard(
                //   name: 'Elon Musk',
                //   subTitle: 'Meeting For StarLink New Project',
                //   time: '10:20 Am',
                //   date: '09/04/2024',
                //   day: 'Monday',
                //   status: 'Cancel',
                //   onTap: () {},
                // ),
                // const GapWidget(size: -8),
                // MeetingCard(
                //   name: 'Bilal Khatri',
                //   subTitle: 'For Meeting',
                //   time: '11:00 Am',
                //   date: '07/04/2024',
                //   day: 'SATURDAY',
                //   status: 'Visited',
                //   onTap: () {},
                // ),
                const GapWidget(size: -8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
