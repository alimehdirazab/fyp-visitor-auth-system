import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fyp/core/ui.dart';
import 'package:fyp/logic/cubits/user_cubit/user_cubit.dart';
import 'package:fyp/logic/cubits/user_cubit/user_state.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/provider/visitor_login_provider.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/auth/visitor_signup_screen.dart';
import 'package:fyp/presentation/pages/Visitors_Screens/home/visitor_home_screen.dart';
import 'package:fyp/presentation/pages/loading_screen.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/link_button.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';
import 'package:fyp/presentation/widgets/primary_textfield.dart';
import 'package:provider/provider.dart';

class VisitorLoginScreen extends StatefulWidget {
  const VisitorLoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<VisitorLoginScreen> createState() => _VisitorLoginScreenState();
}

class _VisitorLoginScreenState extends State<VisitorLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VisitorLoginProvider>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, LoadingScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Log In '),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
            child: Form(
          key: provider.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Log In ', style: TextStyles.heading2),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LinkButton(
                    onPressed: () {},
                    text: "Forget Password",
                  ),
                ],
              ),
              const GapWidget(),
              PrimaryButton(
                onPressed: provider.logIn,
                text: (provider.isLoading) ? "..." : "log In",
              ),
              const GapWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  LinkButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, VisitorSignupScreen.routeName);
                    },
                    text: "Sign Up",
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
