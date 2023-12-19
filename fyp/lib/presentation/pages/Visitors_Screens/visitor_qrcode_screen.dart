import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_form_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_home_screen.dart';

class VisitorQrcodeScreen extends StatelessWidget {
  const VisitorQrcodeScreen({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/images/smiu_qrcode.png'),
            const Text(
                'Show This QrCode To Security Guard To Enter In University\n\n'),
            const Text(
              'Note This Qr Code will only Activate Before 15 mints form Your Meeting Time',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }
}
