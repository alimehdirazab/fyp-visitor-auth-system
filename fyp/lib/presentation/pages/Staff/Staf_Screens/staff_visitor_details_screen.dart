import 'package:flutter/material.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/primary_textfield.dart';

class StaffVisitorDetailsScreen extends StatefulWidget {
  const StaffVisitorDetailsScreen({super.key});
  static const String routeName = "staffVisitorDetailsScreen";

  @override
  State<StaffVisitorDetailsScreen> createState() =>
      _StaffVisitorDetailsScreenState();
}

class _StaffVisitorDetailsScreenState extends State<StaffVisitorDetailsScreen> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _cnic = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _residentialAddress = TextEditingController();
  final TextEditingController _purposeOfVisiting = TextEditingController();
  @override
  void initState() {
    super.initState();
    _fullName.text = 'Ali Mehdi Raza';
    _gender.text = 'Male';
    _cnic.text = '4520411891797';
    _mobileNumber.text = '03073064292';
    _emailAddress.text = 'alimehdirazab@gmail.com';
    _residentialAddress.text = 'Karachi';
    _purposeOfVisiting.text = 'For Fyp Meeting';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitor\'s Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              PrimaryTextField(
                labelText: 'Full Name',
                enablefield: false,
                controller: _fullName,
              ),
              const GapWidget(),
              PrimaryTextField(
                labelText: 'Gender',
                enablefield: false,
                controller: _gender,
              ),
              const GapWidget(),
              PrimaryTextField(
                labelText: 'CNIC',
                enablefield: false,
                controller: _cnic,
              ),
              const GapWidget(),
              PrimaryTextField(
                labelText: 'Mobile Number',
                enablefield: false,
                controller: _mobileNumber,
              ),
              const GapWidget(),
              PrimaryTextField(
                labelText: 'Email Address',
                enablefield: false,
                controller: _emailAddress,
              ),
              const GapWidget(),
              PrimaryTextField(
                labelText: 'Residential address',
                enablefield: false,
                controller: _residentialAddress,
              ),
              const GapWidget(),
              PrimaryTextField(
                labelText: 'Purpose Of Visiting',
                enablefield: false,
                controller: _purposeOfVisiting,
              ),
              const GapWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
