import 'package:flutter/material.dart';
import 'package:fyp/main.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_form_screen.dart';

class VisitorLoginScreen extends StatefulWidget {
  const VisitorLoginScreen({super.key});

  @override
  State<VisitorLoginScreen> createState() => _VisitorLoginScreenState();
}

class _VisitorLoginScreenState extends State<VisitorLoginScreen> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitor Login'),
      ),
      body: Stack(
        children: [
          //app icon
          AnimatedPositioned(
            width: mq.width * 0.50,
            top: mq.height * 0.15,
            right: _isAnimated ? mq.width * 0.25 : -mq.width * 0.5,
            duration: const Duration(seconds: 1),
            child: Image.asset('assets/images/smiu_logo.png'),
          ),
          // login button
          Positioned(
            width: mq.width * 0.9,
            height: mq.height * 0.06,
            bottom: mq.height * 0.15,
            left: mq.width * 0.05,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 223, 255, 187),
                elevation: 1,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const VisitorFormScreen(),
                    ));
              },
              icon: Image.asset(
                'assets/images/google.png',
                height: mq.height * 0.04,
              ),
              label: RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                    TextSpan(text: 'Log In With'),
                    TextSpan(
                        text: ' Google',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ])),
            ),
          ),
        ],
      ),
    );
  }
}
