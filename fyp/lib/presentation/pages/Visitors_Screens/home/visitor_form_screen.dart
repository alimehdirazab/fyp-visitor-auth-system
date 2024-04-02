import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/visitor_home_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_wait_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/widgets/visitor_upload_Button.dart';
import 'package:fyp/presentation/widgets/custom_dropdown_button.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';
import 'package:fyp/presentation/widgets/primary_textfield.dart';

class VisitorFormScreen extends StatefulWidget {
  const VisitorFormScreen({super.key});

  @override
  State<VisitorFormScreen> createState() => _VisitorFormScreenState();
}

class _VisitorFormScreenState extends State<VisitorFormScreen> {
  List<String> departments = <String>[
    'Select Department',
    'Computer Science',
    'BBA',
    'Education',
    'Media Science',
    'Addmission',
    'Transport',
  ];
  List<String> staffNames = <String>[
    'Select Staff Name',
    'John Doe',
    'Jane Smith',
    'Michael Johnson',
    'Emily Davis',
    'David Wilson',
    'Sarah Thompson',
  ];

  final border = const OutlineInputBorder(
      //borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(
    color: Colors.black,
    style: BorderStyle.solid,
    width: 2,
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Appointment Form'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const PrimaryTextField(labelText: 'Full Name'),
              const GapWidget(),
              const PrimaryTextField(labelText: 'CNIC'),
              const GapWidget(),
              const PrimaryTextField(labelText: 'Mobile Number'),
              const GapWidget(),
              const PrimaryTextField(labelText: 'Email Address'),
              const GapWidget(),
              const PrimaryTextField(labelText: 'Adrees'),
              const GapWidget(),
              const PrimaryTextField(labelText: 'Purpose Of Visiting'),
              const GapWidget(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Select Department*'),
                  CustomDropdownButton(items: departments)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Select Staf Name*'),
                  CustomDropdownButton(items: staffNames)
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    VisitorUploadButton(
                      width: 100,
                      height: 30,
                      text: 'CNIC Front',
                      onTap: () {},
                    ),
                    const GapWidget(),
                    VisitorUploadButton(
                      width: 100,
                      height: 30,
                      text: 'CNIC Back',
                      onTap: () {},
                    ),
                    const GapWidget(),
                    VisitorUploadButton(
                      width: 100,
                      height: 30,
                      text: 'Selfie',
                      onTap: () {},
                    ),
                    const GapWidget(),
                  ],
                ),
              ),
              const GapWidget(),

              // submit form
              PrimaryButton(
                text: 'Submit',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
