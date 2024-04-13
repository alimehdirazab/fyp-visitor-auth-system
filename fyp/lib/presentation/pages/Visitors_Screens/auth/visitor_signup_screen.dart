import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/provider/visitor_signup_provider.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/visitor_login_screen.dart';

import 'package:fyp/presentation/pages/loading_screen.dart';

import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/google_button.dart';
import 'package:fyp/presentation/widgets/link_button.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';
import 'package:fyp/presentation/widgets/primary_textfield.dart';
import 'package:provider/provider.dart';

class VisitorSignupScreen extends StatefulWidget {
  const VisitorSignupScreen({super.key});

  static const String routeName = "signup";

  @override
  State<VisitorSignupScreen> createState() => _VisitorSignupScreenState();
}

class _VisitorSignupScreenState extends State<VisitorSignupScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VisitorSignupProvider>(context);
    return BlocListener<VisitorCubit, VisitorState>(
      listener: (context, state) {
        if (state is VisitorLoggedInState ||
            state is VisitorEmailNotVerifiedState ||
            state is VisitorEmailVerifiedState ||
            state is VisitorErrorState) {
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
                  Text('Create Account ', style: TextStyles.heading2),
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
                  const GapWidget(),
                  PrimaryTextField(
                    obscureText: true,
                    controller: provider.cPasswordController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Confirm Your Paasword!";
                      }
                      if (value.trim() !=
                          provider.passwordController.text.trim()) {
                        return "passwords do not match!";
                      }
                      return null;
                    },
                    labelText: "Confirm Password",
                  ),
                  const GapWidget(),
                  PrimaryButton(
                    onPressed: provider.createAccount,
                    // onPressed: () => Navigator.pushReplacementNamed(
                    //     context, OtpScreen.routeName),
                    text: (provider.isLoading) ? "..." : "Create Account",
                  ),
                  const GapWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LinkButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, VisitorLoginScreen.routeName);
                        },
                        text: "Already have an account?",
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
