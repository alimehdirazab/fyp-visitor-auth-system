import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/presentation/widgets/custom_dropdown_button.dart';
import 'package:fyp/presentation/widgets/searchable_dropdown_button.dart';
import 'package:fyp/presentation/widgets/total_value_card.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({super.key});

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
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
            // SizedBox(
            //   width: mq.width,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       SizedBox(
            //         width: mq.width * 0.70,
            //         child: const TextField(
            //           decoration: InputDecoration(hintText: "Search here..."),
            //         ),
            //       ),
            //       IconButton(
            //           onPressed: () {}, icon: const Icon(Icons.filter_alt))
            //     ],
            //   ),
            // ),
            //const GapWidget(),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TotalValueCard(
                    total: 20,
                    value: 'Visitors Expacted',
                    color: Colors.blue,
                    icon: Icons.group,
                  ),
                  TotalValueCard(
                    total: 20,
                    value: 'Completed Meetings',
                    color: Colors.green,
                    icon: Icons.done,
                  ),
                ],
              ),
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TotalValueCard(
                    total: 20,
                    value: 'Cancel Meetings',
                    color: Colors.red,
                    icon: Icons.person_off,
                  ),
                  TotalValueCard(
                    total: 20,
                    value: 'Pending Meetings ',
                    color: Colors.orange,
                    icon: Icons.group,
                  ),
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
                card('Ali Mehdi Raza', 'For Fyp Meeting', 'pending'),
                card(
                    'Elon Musk', 'Meeting For StarLink New Project', 'pending'),
                card('Bilal Khatri', 'For Meeting', 'Visited'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget card(String name, String reason, String status) {
    return Card(
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text(name),
          subtitle: Text(reason),
          trailing: Column(
            children: [
              const Text('10:30 \nWednesday'),
              Text(status,
                  style: TextStyle(
                      color: status == 'pending' ? Colors.red : Colors.green))
            ],
          ),
        ),
      ),
    );
  }
}
