import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/visitor_home_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_wait_screen.dart';

class VisitorFormScreen extends StatefulWidget {
  const VisitorFormScreen({super.key});

  @override
  State<VisitorFormScreen> createState() => _VisitorFormScreenState();
}

class _VisitorFormScreenState extends State<VisitorFormScreen> {
  List<String> list = <String>[
    'Select Department',
    'Computer Science',
    'BBA',
    'Education',
    'Media Science',
    'Addmission',
    'Transport',
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
    String dropdownValue = list.first;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Your Full Name",
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Your CNIC",
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Your Phone Number",
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Your Adress",
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "Purpose of Visiting",
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Select Department*'),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    underline: Container(
                      height: 2,
                      width: 10,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Select Staf Name*'),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    underline: Container(
                      height: 2,
                      width: 10,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text('upload Cnic Front')),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text('upload Cnic Back')),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {}, child: const Text('Take a Selfie Pic')),
              const SizedBox(height: 10),
              // submit form
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VisitorWaitScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 41, 148, 219),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Submit Form',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
