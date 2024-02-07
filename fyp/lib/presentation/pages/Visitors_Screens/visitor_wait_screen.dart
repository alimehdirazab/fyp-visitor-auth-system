import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/visitor_form_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/visitor_home_screen.dart';

class VisitorWaitScreen extends StatelessWidget {
  const VisitorWaitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VisitorHomeScreen(),
                  ));
            },
            icon: const Icon(Icons.home)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VisitorFormScreen(),
                  ));
            },
            icon: const Icon(
              Icons.add_circle_outline_rounded,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text(
              'Waiting For Permission',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
