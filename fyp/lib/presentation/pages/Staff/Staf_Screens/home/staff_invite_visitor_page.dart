import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';

class StaffInviteVisitorPage extends StatefulWidget {
  const StaffInviteVisitorPage({super.key});

  @override
  State<StaffInviteVisitorPage> createState() => _StaffInviteVisitorPageState();
}

class _StaffInviteVisitorPageState extends State<StaffInviteVisitorPage> {
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
            onPressed: () {},
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
