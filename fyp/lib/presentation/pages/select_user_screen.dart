import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Staf_Sreens/staf_login_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/provider/login_provider.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/visitor_login_screen.dart';
import 'package:provider/provider.dart';

class SelectUserScreen extends StatelessWidget {
  const SelectUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Image.asset('assets/images/smiu_logo.png'),
                    ),
                    const Text(
                      'Visitor Authorization System',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                  create: (context) => LoginProvider(context),
                                  child: const VisitorLoginScreen()),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 41, 148, 219),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Visitor',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const StafLoginScreen(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 41, 148, 219),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Staf',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const StafLoginScreen(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 41, 148, 219),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Security',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
