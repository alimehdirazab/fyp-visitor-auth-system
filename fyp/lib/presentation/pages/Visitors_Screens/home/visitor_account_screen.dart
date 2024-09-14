import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/data/models/appointment/appointment_data_model.dart';
import 'package:fyp/data/models/visitor/visitor_update_details_model.dart';
import 'package:fyp/data/repositories/visitor_repository.dart'; // Import repository
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';
import 'package:fyp/logic/services/location_service.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/logic/services/visitor_preferences.dart';
import 'package:fyp/presentation/pages/LoadingScreens/visitor_loading_screen.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';
import 'package:fyp/presentation/widgets/profile_tile.dart';
import 'package:image_picker/image_picker.dart';

class VisitorAccountScreen extends StatefulWidget {
  const VisitorAccountScreen({super.key});

  @override
  State<VisitorAccountScreen> createState() => _VisitorAccountScreenState();
}

class _VisitorAccountScreenState extends State<VisitorAccountScreen> {
  String? name;
  String? email;
  String? phone;
  String? profilePicture;

  @override
  void initState() {
    super.initState();
    _fetchVisitorDetails();
  }

  static Future<List<AppointmentDataModel>>
      getAppointmentsWithStatusEntered() async {
    try {
      print(
          'Fetching appointments with status "entered", "running", or "redListed"');
      final visitorCubit = VisitorCubitSingleton.getInstance();
      await visitorCubit.fetchAppointments();
      final state = visitorCubit.state;

      if (state is VisitorAppointmentFetchLoadedState) {
        print('Appointments fetched successfully');
        return state.appointmentData.where((appointment) {
          return appointment.status == 'entered' ||
              appointment.status == 'running' ||
              appointment.status == 'redListed';
        }).toList();
      } else {
        print('Failed to fetch appointments or no appointments found');
        return [];
      }
    } catch (e) {
      print('Error fetching appointments: $e');
      return [];
    }
  }

  static Future<bool> canLogout() async {
    // Fetch appointments with status "entered", "running", or "redListed"
    final appointments = await getAppointmentsWithStatusEntered();
    return appointments.isEmpty;
  }

  Future<void> _fetchVisitorDetails() async {
    final details = await VisitorPreferences.fetchVisitorDetails();
    setState(() {
      name = details['visitorName'];
      email = details['email'];
      phone = details['phoneNumber'];
      profilePicture = details['profilePicture'];
    });
  }

  Future<void> _updateVisitorDetail({
    String? name,
    String? phone,
    String? profilePic,
    String? password, // Add password here
  }) async {
    final visitorRepo = VisitorRepository();

    try {
      VisitorUpdateDetailsModel updatedDetails =
          await visitorRepo.updateVisitorIndividualDetail(
        name: name,
        phone: phone,
        profilePic: profilePic,
        password: password, // Include password in the update
      );

      // Save the updated details in VisitorPreferences
      await VisitorPreferences.updateVisitorDetails(
        visitorName: updatedDetails.name,
        phoneNumber: updatedDetails.phone,
        profilePicture: updatedDetails.profilePic,
        password: password, // Save password if updated
      );

      // Update local state
      setState(() {
        this.name = updatedDetails.name;
        this.phone = updatedDetails.phone;
        this.profilePicture = updatedDetails.profilePic;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Details updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update details: $e')),
      );
    }
  }

  //pick image
  Future<String?> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // Pick an image from the gallery
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    // Check if an image was selected
    if (image != null) {
      return image.path; // Return the path of the selected image
    } else {
      // Handle the case when no image was selected
      return null;
    }
  }

  //////
  void _updateProfileImage() async {
    final String? filePath =
        await _pickImage(); // Call _pickImage to select an image

    if (filePath != null) {
      final String fileName =
          filePath.split('/').last; // Extract the file name from the path
      await updateProfileImage(fileName,
          filePath); // Call the function to upload and update the image
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
    }
  }

  //update Profile Pic
  Future<void> updateProfileImage(String fileName, String filePath) async {
    try {
      final visitorRepo = VisitorRepository();
      // Call the existing uploadFile function to upload the image
      final String imageUrl = await visitorRepo.uploadFile(
        fileName: fileName,
        filePath: filePath,
      );

      // Update the visitor details with the new image URL
      await _updateVisitorDetail(profilePic: imageUrl);

      // Notify user of success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile image updated successfully')),
      );
    } catch (e) {
      // Handle any errors that occur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile image: $e')),
      );
    }
  }

  //Edit Name
  void _editName() {
    TextEditingController nameController = TextEditingController(text: name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Name'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _updateVisitorDetail(name: nameController.text);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // Edit Phone
  void _editPhone() {
    TextEditingController phoneController = TextEditingController(text: phone);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Phone'),
        content: TextField(
          controller: phoneController,
          decoration: const InputDecoration(labelText: 'Phone'),
          keyboardType: TextInputType
              .phone, // Ensure the keyboard is optimized for phone input
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _updateVisitorDetail(phone: phoneController.text);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editPassword() {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    bool oldPasswordValid = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Change Password'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: oldPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'Old Password'),
                    obscureText: true,
                  ),
                  if (oldPasswordValid) ...[
                    TextField(
                      controller: newPasswordController,
                      decoration:
                          const InputDecoration(labelText: 'New Password'),
                      obscureText: true,
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (!oldPasswordValid) {
                      // Check if the old password is correct
                      final visitorDetails =
                          await VisitorPreferences.fetchVisitorDetails();
                      String storedPassword = visitorDetails['password'];

                      if (oldPasswordController.text == storedPassword) {
                        // Old password is correct, allow user to enter new password
                        setState(() {
                          oldPasswordValid = true;
                        });
                      } else {
                        // Old password is incorrect
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Incorrect old password'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    } else {
                      // Save new password
                      if (newPasswordController.text.isNotEmpty) {
                        await _updateVisitorDetail(
                            password: newPasswordController.text);
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('New password cannot be empty'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                  },
                  child: Text(oldPasswordValid ? 'Save' : 'Next'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 3, bottom: 3),
                    child: ClipOval(
                      child: profilePicture != null
                          ? CachedNetworkImage(
                              imageUrl: profilePicture!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.person, size: 120),
                            )
                          : const Icon(
                              Icons.person,
                              size: 120,
                            ),
                    ),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: _updateProfileImage,
                      icon: const Icon(Icons.camera_alt),
                    ),
                  ),
                ],
              ),
              const GapWidget(size: 20),
              ProfileTile(
                leadingIcon: Icons.person,
                title: 'Name',
                subtitle: name ?? 'Add your name',
                onPressed: _editName, // Edit name
              ),
              ProfileTile(
                leadingIcon: Icons.email_outlined,
                title: 'Email',
                subtitle: email ?? 'Add your email',
                editMode: false,
              ),
              ProfileTile(
                leadingIcon: Icons.phone,
                title: 'Phone',
                subtitle: phone ?? 'Add your phone number',
                onPressed: _editPhone,
              ),
              ProfileTile(
                leadingIcon: Icons.lock,
                title: 'Password',
                subtitle: '*********',
                onPressed: _editPassword,
              ),
              const GapWidget(size: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: PrimaryButton(
                  onPressed: () async {
                    if (await canLogout()) {
                      BlocProvider.of<VisitorCubit>(context).signOut();
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacementNamed(
                          context, VisitorLoadingScreen.routeName);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Logout Restricted'),
                          content: const Text(
                              'You cannot logout while an appointment is in progress.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  text: "Log out",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
