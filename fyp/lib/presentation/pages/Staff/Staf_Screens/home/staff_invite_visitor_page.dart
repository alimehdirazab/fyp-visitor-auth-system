import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fyp/presentation/widgets/custom_dropdown_button.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/meeting_card.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';

class StaffInviteVisitorPage extends StatefulWidget {
  const StaffInviteVisitorPage({super.key});

  @override
  State<StaffInviteVisitorPage> createState() => _StaffInviteVisitorPageState();
}

class _StaffInviteVisitorPageState extends State<StaffInviteVisitorPage> {
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();

  List<String> names = [
    "Select Name",
    "Ali Mehdi",
    "Bilal Khatri",
    "Ishaque ul Hassan",
    "Elon Musk"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 4,
              right: MediaQuery.of(context).size.width / 4),
          child: CupertinoButton(
            padding: const EdgeInsets.all(10),
            color: Colors.grey.shade800,
            child: const Row(
              children: [
                Icon(Icons.add_box_outlined, size: 30),
                SizedBox(width: 10),
                Text('Create Invite'),
              ],
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -8),
                          child: Container(
                            height: 5,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey),
                          ),
                        ),
                        Text(
                          "Invite Visitor",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const GapWidget(),
                        // CustomDropdownButton(items: names),
                        const GapWidget(),
                        Text(
                          '${date.day}:${date.month}:${date.year}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final DateTime? selectedDate =
                                  await showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2099));
                              if (selectedDate != null) {
                                setState(() {
                                  date = selectedDate;
                                });
                              }
                            },
                            child: const Text('Choose Date')),
                        const GapWidget(),
                        Text(
                          '${time.hour}:${time.minute}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final TimeOfDay? timeOfDay = await showTimePicker(
                                context: context,
                                initialTime: time,
                                initialEntryMode: TimePickerEntryMode.dial);
                            if (timeOfDay != null) {
                              setState(() {
                                time = timeOfDay;
                              });
                            }
                          },
                          child: const Text('Choose Time'),
                        ),
                        const GapWidget(),
                        PrimaryButton(text: "Invite", onPressed: () {}),
                        const GapWidget(),
                        const GapWidget(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const GapWidget(),
        Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // MeetingCard(
                      //   name: 'Ali Mehdi Raza',
                      //   subTitle: 'For Fyp Meeting',
                      //   time: '10:20 Am',
                      //   date: '07/04/2024',
                      //   day: 'SATURDAY',
                      //   status: 'Pending',
                      //   onTap: () {},
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
                      // const GapWidget(size: -8),
                      // MeetingCard(
                      //   name: 'Ali Mehdi Raza',
                      //   subTitle: 'For Fyp Meeting',
                      //   time: '10:20 Am',
                      //   date: '07/04/2024',
                      //   day: 'SATURDAY',
                      //   status: 'Pending',
                      //   onTap: () {},
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
                    ],
                  ),
                )))
      ],
    );
  }
}
