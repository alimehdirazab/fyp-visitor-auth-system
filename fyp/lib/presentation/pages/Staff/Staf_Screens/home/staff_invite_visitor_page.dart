import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fyp/presentation/widgets/custom_dropdown_button.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
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
                        CustomDropdownButton(items: names),
                        const GapWidget(),
                        Text('${date.day}:${date.month}:${date.year}'),
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
                        Text('${time.hour}:${time.minute}'),
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
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Visitor Name')),
              DataColumn(label: Text('Day')),
              DataColumn(label: Text('Time')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Status')),
            ],
            rows: const [
              DataRow(
                cells: [
                  DataCell(Text('Bilal Ahmed')),
                  DataCell(Text('Monday')),
                  DataCell(Text('10/02/2024')),
                  DataCell(Text('10:40 am')),
                  DataCell(Text('Visited')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('Ishaque Ahmed')),
                  DataCell(Text('Monday')),
                  DataCell(Text('10/02/2024')),
                  DataCell(Text('12:00 pm')),
                  DataCell(Text('Panding')),
                ],
              ),
            ],
          ),
        ))
      ],
    );
  }
}
