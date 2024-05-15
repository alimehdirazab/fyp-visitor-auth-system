import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fyp/data/models/staff/staff_details_model.dart';
import 'package:fyp/data/models/staff/staff_model.dart';
import 'package:fyp/data/repositories/staff_repository.dart';
import 'package:fyp/data/repositories/visitor_repository.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';

import 'package:image_picker/image_picker.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/widgets/visitor_upload_Button.dart';
import 'package:fyp/presentation/widgets/custom_dropdown_button.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';
import 'package:fyp/presentation/widgets/primary_textfield.dart';

class VisitorFormScreen extends StatefulWidget {
  const VisitorFormScreen({Key? key}) : super(key: key);

  @override
  State<VisitorFormScreen> createState() => _VisitorFormScreenState();
}

class _VisitorFormScreenState extends State<VisitorFormScreen> {
  final VisitorRepository _visitorRepository = VisitorRepository();
  List<String> _staffNames = ['Select Name'];
  String? _selectedGender;

  List<String>? staffNames;

  List<String> departments = <String>[
    'Select Department',
    'Computer Science',
    'BBA',
    'Education',
    'Media Science',
    'Admission',
    'Transport',
  ];

  @override
  void initState() {
    super.initState();
    // getStaffNames();
  }

  // Future<void> getStaffNames() async {
  //   try {
  //     List<StaffDetailsModel> staffDetails =
  //         await _visitorRepository.getStaffDetails();

  //     // Check if 'staff' field exists in the response and is a List
  //     if (staffDetails.containsKey('staff') && staffDetails['staff'] is List) {
  //       List<dynamic> staffList = staffDetails['staff'];

  //       // Extract names from staff list
  //       List<String> names = [];
  //       for (var staff in staffList) {
  //         // Ensure each item in the list is a map
  //         if (staff is Map<String, dynamic> && staff.containsKey('name')) {
  //           names.add(staff['name'] as String);
  //         }
  //       }

  //       // Update _staffNames with the extracted names
  //       setState(() {
  //         _staffNames.addAll(names);
  //       });
  //     } else {
  //       print('Error: Staff field not found or not a List in response');
  //     }
  //   } catch (e) {
  //     print('Error fetching staff names: $e');
  //   }
  // }

  final border = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      style: BorderStyle.solid,
      width: 2,
    ),
  );

  File? _cnicFrontImage;
  File? _cnicBackImage;
  File? _selfieImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source, String buttonName) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      switch (buttonName) {
        case 'CNIC Front':
          _cnicFrontImage = File(pickedFile!.path);
          break;
        case 'CNIC Back':
          _cnicBackImage = File(pickedFile!.path);
          break;
        case 'Selfie':
          _selfieImage = File(pickedFile!.path);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GapWidget(size: -12),
              const PrimaryTextField(labelText: 'Full Name'),
              const GapWidget(),
              Text(
                'Select Gender',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.primary),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  const Text('Male'),
                  Radio<String>(
                    value: 'Female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
              const PrimaryTextField(labelText: 'CNIC'),
              const GapWidget(),
              const PrimaryTextField(labelText: 'Mobile Number'),
              const GapWidget(),
              const PrimaryTextField(labelText: 'Email Address'),
              const GapWidget(),
              const PrimaryTextField(labelText: 'Address'),
              const GapWidget(),
              FutureBuilder<List<StaffDetailsModel>>(
                future: _visitorRepository.getStaffDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<String> values = snapshot.data!
                        .map((value) => value.toString())
                        .toList();
                    return CustomDropdownButton(
                      items: values,
                    );
                  }
                },
              ),
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
                  const Text('Select Staff Name*'),
                  CustomDropdownButton(items: _staffNames)
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VisitorUploadButton(
                      width: 100,
                      height: 30,
                      text: 'CNIC Front',
                      onTap: () {
                        _getImage(ImageSource.camera, 'CNIC Front');
                      },
                    ),
                    const GapWidget(),
                    VisitorUploadButton(
                      width: 100,
                      height: 30,
                      text: 'CNIC Back',
                      onTap: () {
                        _getImage(ImageSource.camera, 'CNIC Back');
                      },
                    ),
                    const GapWidget(),
                    VisitorUploadButton(
                      width: 100,
                      height: 30,
                      text: 'Selfie',
                      onTap: () {
                        _getImage(ImageSource.camera, 'Selfie');
                      },
                    ),
                    const GapWidget(),
                  ],
                ),
              ),
              const GapWidget(size: -5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_cnicFrontImage != null)
                    ClipOval(
                      child: Image.file(
                        _cnicFrontImage!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  if (_cnicBackImage != null)
                    ClipOval(
                      child: Image.file(
                        _cnicBackImage!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  if (_selfieImage != null)
                    ClipOval(
                      child: Image.file(
                        _selfieImage!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
              const GapWidget(),
              PrimaryButton(
                text: 'Submit',
                onPressed: () {
                  // Add your submit logic here
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
