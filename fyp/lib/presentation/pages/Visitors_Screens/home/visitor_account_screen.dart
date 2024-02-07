import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/logic/cubits/user_cubit/user_cubit.dart';
import 'package:fyp/presentation/pages/loading_screen.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';

class VisitorAccountScreen extends StatefulWidget {
  const VisitorAccountScreen({super.key});

  @override
  State<VisitorAccountScreen> createState() => _VisitorAccountScreenState();
}

class _VisitorAccountScreenState extends State<VisitorAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            PrimaryButton(
              onPressed: () {
                BlocProvider.of<UserCubit>(context).signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacementNamed(
                    context, LoadingScreen.routeName);
              },
              text: "Log out",
            ),
          ],
        ),
      ),
    );
  }
}
