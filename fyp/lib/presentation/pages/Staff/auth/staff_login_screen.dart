import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_state.dart';

import 'package:fyp/presentation/pages/Staff/Staf_Screens/home/staff_home_screen.dart';
import 'package:fyp/presentation/pages/Staff/auth/provider/staff_login_provider.dart';
import 'package:fyp/presentation/pages/loading_screen.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/google_button.dart';
import 'package:fyp/presentation/widgets/link_button.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';
import 'package:fyp/presentation/widgets/primary_textfield.dart';
import 'package:provider/provider.dart';

class StaffLoginScreen extends StatefulWidget {
  const StaffLoginScreen({super.key});

  static const String routeName = "staffLogin";

  @override
  State<StaffLoginScreen> createState() => _StaffLoginScreenState();
}

class _StaffLoginScreenState extends State<StaffLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StaffLoginProvider>(context);
    return BlocListener<StaffCubit, StaffState>(
      listener: (context, state) {
        if (state is StaffLoggedInState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, LoadingScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Form(
          key: provider.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const GapWidget(size: -6),
                  Text('Login ', style: TextStyles.heading2),
                  const GapWidget(),
                  const GapWidget(),
                  (provider.error != "")
                      ? Text(
                          provider.error,
                          style: const TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                  const GapWidget(),
                  PrimaryTextField(
                    controller: provider.emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email Address is Required!";
                      }
                      if (!EmailValidator.validate(value.trim())) {
                        return "Invalid Email Address";
                      }
                      return null;
                    },
                    labelText: "Email Address",
                  ),
                  const GapWidget(),
                  PrimaryTextField(
                    obscureText: true,
                    controller: provider.passwordController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Paasword is required!";
                      }
                      return null;
                    },
                    labelText: "Password",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GapWidget(),
                      LinkButton(
                        onPressed: () {},
                        text: "Forget Password?",
                      ),
                    ],
                  ),
                  const GapWidget(),
                  PrimaryButton(
                    onPressed: provider.logIn,
                    // onPressed: () {
                    //   Navigator.pushReplacementNamed(
                    //       context, StaffHomeScreen.routeName);
                    // },
                    text: (provider.isLoading) ? "..." : "login",
                  ),
                  const GapWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      LinkButton(
                        onPressed: () {},
                        text: "SignUp",
                      ),
                    ],
                  ),
                  const GapWidget(size: 16),
                  Text(
                    'or',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  const GapWidget(size: 16),
                  GoogleButton(
                    onTap: () {},
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
