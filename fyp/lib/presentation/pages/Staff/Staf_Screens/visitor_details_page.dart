import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/widgets/zoomable_image_view.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/visitor_details_tile.dart';
import 'package:intl/intl.dart';

class VisitorDetailsPage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String profilePic;
  final String cnicFrontPic;
  final String cnicBackPic;
  final String status;

  const VisitorDetailsPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.profilePic,
    required this.cnicFrontPic,
    required this.cnicBackPic,
    required this.status,
  });

  @override
  // ignore: library_private_types_in_public_api
  _VisitorDetailsPageState createState() => _VisitorDetailsPageState();
}

class _VisitorDetailsPageState extends State<VisitorDetailsPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _secureScreen();
  }

  Future<void> _secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  void _openImageView(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ZoomableImageView(imageUrl: imageUrl),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _showRescheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reschedule Appointment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(_selectedDate == null
                    ? 'Select Date'
                    : DateFormat('yyyy-MM-dd').format(_selectedDate!)),
              ),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text(_selectedTime == null
                    ? 'Select Time'
                    : _selectedTime!.format(context)),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Reschedule',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                if (_selectedDate == null || _selectedTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Please select both date and time'),
                    ),
                  );
                } else {
                  // Perform reschedule logic here
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitor Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Visitor Details', style: TextStyles.heading2),
                const SizedBox(height: 16),
                VisitorDetailsTile(
                  leadingIcon: Icons.person,
                  title: 'Name',
                  subtitle: widget.name,
                ),
                VisitorDetailsTile(
                  leadingIcon: Icons.email,
                  title: 'Email',
                  subtitle: widget.email,
                ),
                VisitorDetailsTile(
                  leadingIcon: Icons.phone,
                  title: 'Phone',
                  subtitle: widget.phone,
                ),
                const GapWidget(),
                Text('Visitor Profile Picture', style: TextStyles.body2),
                const GapWidget(),
                GestureDetector(
                  onTap: () => _openImageView(context, widget.profilePic),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: CachedNetworkImage(
                        imageUrl: widget.profilePic,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                const GapWidget(),
                Text('Visitor Front CNIC Picture', style: TextStyles.body2),
                const GapWidget(),
                GestureDetector(
                  onTap: () => _openImageView(context, widget.cnicFrontPic),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: CachedNetworkImage(
                        imageUrl: widget.cnicFrontPic,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                const GapWidget(),
                Text('Visitor Back CNIC Picture', style: TextStyles.body2),
                const GapWidget(),
                GestureDetector(
                  onTap: () => _openImageView(context, widget.cnicBackPic),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: CachedNetworkImage(
                        imageUrl: widget.cnicBackPic,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                const GapWidget(),
                widget.status == 'entered'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade100,
                            ),
                            icon: const Icon(Icons.check),
                            label: const Text('Reached'),
                            onPressed: () {
                              // Perform reached logic here
                            },
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade100,
                            ),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                            label: const Text('Not Reached',
                                style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              // Perform not reached logic here
                            },
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade100,
                                ),
                                icon: const Icon(
                                  Icons.check,
                                ),
                                label: const Text('Accept'),
                                onPressed: () {
                                  // Perform accept logic here
                                },
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade100,
                                ),
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                label: const Text(
                                  'Reject',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  // Perform reject logic here
                                },
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade100,
                            ),
                            icon: const Icon(
                              Icons.schedule,
                              color: Colors.blue,
                            ),
                            label: const Text(
                              'Reschedule',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () => _showRescheduleDialog(context),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
