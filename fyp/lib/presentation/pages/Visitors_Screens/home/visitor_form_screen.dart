import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/data/models/staff/staff_details_model.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';
import 'package:fyp/logic/services/visitor_preferences.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/provider/visitor_appointment_form_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/widgets/visitor_upload_Button.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';
import 'package:fyp/presentation/widgets/primary_textfield.dart';
import 'package:flutter_searchable_dropdown/flutter_searchable_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;

class VisitorFormScreen extends StatefulWidget {
  const VisitorFormScreen({Key? key}) : super(key: key);

  @override
  State<VisitorFormScreen> createState() => _VisitorFormScreenState();
}

class _VisitorFormScreenState extends State<VisitorFormScreen> {
  File? _cnicFrontImagePath;
  String _cnicFrontImageName = '';
  File? _cnicBackImagePath;
  String _cnicBackImageName = '';
  File? _selfieImagePath;
  String _selfieImageName = '';

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Fetch users when the screen initializes
    context.read<VisitorCubit>().fetchUsers();
  }

  Future<void> _getImage(ImageSource source, String buttonName) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);
        final img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

        if (image != null) {
          final img.Image resizedImage = img.copyResize(image, width: 500);

          final File compressedImageFile = File(pickedFile.path)
            ..writeAsBytesSync(img.encodeJpg(resizedImage, quality: 65));

          switch (buttonName) {
            case 'CNIC Front':
              _cnicFrontImagePath = compressedImageFile;
              _cnicFrontImageName = pickedFile.name;
              break;
            case 'CNIC Back':
              _cnicBackImagePath = compressedImageFile;
              _cnicBackImageName = pickedFile.name;
              break;
            case 'Selfie':
              _selfieImagePath = compressedImageFile;
              _selfieImageName = pickedFile.name;
              break;
          }
        }
      }
    });
  }

  Future<void> _uploadImagesAndSubmit() async {
    try {
      if (_cnicFrontImagePath == null ||
          _cnicBackImagePath == null ||
          _selfieImagePath == null) {
        throw 'Please upload all required images.';
      }

      final visitorCubit = context.read<VisitorCubit>();

      final cnicFrontUrl = await visitorCubit.uploadFile(
        fileName: _cnicFrontImageName,
        filePath: _cnicFrontImagePath!.path,
      );
      final cnicBackUrl = await visitorCubit.uploadFile(
        fileName: _cnicBackImageName,
        filePath: _cnicBackImagePath!.path,
      );
      final selfieUrl = await visitorCubit.uploadFile(
        fileName: _selfieImageName,
        filePath: _selfieImagePath!.path,
      );

      if (cnicFrontUrl.isNotEmpty &&
          cnicBackUrl.isNotEmpty &&
          selfieUrl.isNotEmpty) {
        Provider.of<VisitorAppointmentFormProvider>(context, listen: false)
          ..cnicFrontPic = cnicFrontUrl
          ..cnicBackPic = cnicBackUrl
          ..profilePic = selfieUrl;

        Provider.of<VisitorAppointmentFormProvider>(context, listen: false)
            .updateVisitorDetails();
      } else {
        throw 'Image upload failed';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VisitorAppointmentFormProvider>(context);
    TimeOfDay time = TimeOfDay.now();
    DateTime date = DateTime.now();

    return BlocListener<VisitorCubit, VisitorState>(
      listener: (context, state) async {
        if (state is VisitorDetailsUpdateErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is VisitorDetailsUpdatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Visitor details updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
          // If the visitor details are updated successfully, save the appointment
          Provider.of<VisitorAppointmentFormProvider>(context, listen: false)
              .saveAppointment();
        } else if (state is VisitorAppointmentSaveErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is VisitorAppointmentSavedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Appointment saved successfully'),
              backgroundColor: Colors.green,
            ),
          );
          String? vistorName = state.appointmentData.visitor.name;
          String? vistorPhone = state.appointmentData.visitor.phone;

          String? visitorProfilePicture =
              state.appointmentData.visitor.profilePic?.fileUrl;
          await VisitorPreferences.updateVisitorDetails(
              visitorName: vistorName,
              phoneNumber: vistorPhone,
              profilePicture: visitorProfilePicture);
          // setState(() {
          //   _cnicFrontImagePath = null;
          //   _cnicBackImagePath = null;
          //   _selfieImagePath = null;
          //   _cnicFrontImageName = '';
          //   _cnicBackImageName = '';
          //   _selfieImageName = '';
          //   provider.nameController.clear();
          //   provider.phoneController.clear();
          //   provider.purposeController.clear();
          // });
        }
      },
      child: Scaffold(
        body: Form(
          key: provider.formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GapWidget(size: -12),
                  (provider.error != "")
                      ? Text(
                          provider.error,
                          style: const TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                  const GapWidget(size: -12),
                  PrimaryTextField(
                    labelText: 'Full Name',
                    controller: provider.nameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  const GapWidget(),
                  PrimaryTextField(
                    labelText: 'Mobile Number',
                    keyboardType: TextInputType.phone,
                    controller: provider.phoneController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Phone number is required';
                      }
                      return null;
                    },
                  ),
                  const GapWidget(),
                  PrimaryTextField(
                    labelText: 'Purpose Of Visiting',
                    controller: provider.purposeController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Purpose is required';
                      }
                      return null;
                    },
                  ),
                  const GapWidget(),
                  BlocBuilder<VisitorCubit, VisitorState>(
                    builder: (context, state) {
                      if (state is VisitorStaffDetailsLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is VisitorStaffDetailsLoadedState) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SearchableDropdown.single(
                            items: state.staff.map((staff) {
                              return DropdownMenuItem<StaffDetailsData>(
                                value: staff,
                                child: Text(staff.name ?? 'No Name Found'),
                              );
                            }).toList(),
                            onChanged: (StaffDetailsData? selectedUser) {
                              if (selectedUser != null) {
                                provider.userId = selectedUser.id;
                                print('Selected user ID: ${selectedUser.id}');
                              }
                            },
                            isExpanded: true,
                            displayClearIcon:
                                false, // Optional, hides clear icon
                            hint: 'Select a user',
                            searchHint: 'Search user by name',
                          ),
                        );
                      } else if (state is VisitorStaffDetailsErrorState) {
                        return Center(child: Text(state.message));
                      }
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                  ),
                  const GapWidget(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (_cnicFrontImagePath != null)
                        ClipOval(
                          child: Image.file(
                            _cnicFrontImagePath!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (_cnicBackImagePath != null)
                        ClipOval(
                          child: Image.file(
                            _cnicBackImagePath!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (_selfieImagePath != null)
                        ClipOval(
                          child: Image.file(
                            _selfieImagePath!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                  const GapWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              final DateTime? selectedDate =
                                  await showDatePicker(
                                      context: context,
                                      initialDate: date,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2099));
                              if (selectedDate != null) {
                                setState(() {
                                  date = selectedDate;
                                  provider.appointmentDate = date;
                                });
                              }
                            },
                            child: const Text('Choose Date'),
                          ),
                          provider.appointmentDate != null
                              ? Text(
                                  '${provider.appointmentDate?.day}:${provider.appointmentDate?.month}:${provider.appointmentDate?.year}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  '${date.day}:${date.month}:${date.year}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                      const GapWidget(),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: time,
                                  initialEntryMode: TimePickerEntryMode.dial);
                              if (timeOfDay != null) {
                                setState(() {
                                  time = timeOfDay;
                                  provider.appointmentTime = time;
                                });
                              }
                            },
                            child: const Text('Choose Time'),
                          ),
                          provider.appointmentTime != null
                              ? Text(
                                  '${provider.appointmentTime?.hour}:${provider.appointmentTime?.minute}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  '${time.hour}:${time.minute}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                        ],
                      ),
                    ],
                  ),
                  const GapWidget(),
                  const GapWidget(),
                  PrimaryButton(
                    text: (provider.isLoading) ? "..." : 'Submit',
                    onPressed: () async {
                      await _uploadImagesAndSubmit();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
