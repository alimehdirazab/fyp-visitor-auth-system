import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/data/repositories/visitor_repository.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_cubit.dart';
import 'package:fyp/logic/cubits/visitor_cubit/visitor_state.dart';
import 'package:fyp/logic/services/visitor_preferences.dart';
import 'package:fyp/presentation/pages/loading_screen.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/link_button.dart';
import 'package:fyp/presentation/widgets/otp_box.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  static const String routeName = "otpScreen";

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late List<TextEditingController> _controllers;
  bool _isResendEnabled = false;
  int _resendTimerSeconds = 60;
  late Timer _resendTimer;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (index) => TextEditingController());
    startResendTimer();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _resendTimer.cancel();
    super.dispose();
  }

  void startResendTimer() {
    _isResendEnabled = false;
    _resendTimerSeconds = 60;
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _resendTimerSeconds--;
        if (_resendTimerSeconds == 0) {
          _isResendEnabled = true;
          _resendTimer.cancel();
        }
      });
    });
  }

  Future<void> verifyEmail(BuildContext context, String otp) async {
    try {
      final visitorData = await VisitorPreferences.fetchVisitorDetails();
      String? visitorId = visitorData["visitorId"];
      context.read<VisitorCubit>().verifyEmail(
            visitorId: visitorId!,
            verificationOTP: otp,
          );
    } catch (ex) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VisitorCubit, VisitorState>(
      listener: (context, state) {
        if (state is VisitorEmailVerifiedState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, LoadingScreen.routeName);
        } else if (state is VisitorEmailNotVerifiedState ||
            state is VisitorErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Incorrect OTP, please try again.'),
            duration: Duration(seconds: 3),
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text('OTP Verification', style: TextStyles.heading2),
                  const GapWidget(),
                  Text(
                    'Enter the code from the email we sent to alimehdirazab@gmail.com',
                    textAlign: TextAlign.center,
                    style: TextStyles.body2
                        .copyWith(color: const Color(0xff565656)),
                  ),
                  const GapWidget(size: 30),
                  Text('00:$_resendTimerSeconds',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20)),
                  const GapWidget(size: 30),
                  Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => Expanded(
                          child: OtpBox(
                            controller: _controllers[index],
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t receive the OTP? '),
                      LinkButton(
                        text: 'RESEND',
                        onPressed: _isResendEnabled
                            ? () async {
                                startResendTimer();
                                final userDetails = await VisitorPreferences
                                    .fetchVisitorDetails();
                                String? email = userDetails["email"];
                                BlocProvider.of<VisitorCubit>(context)
                                    .resendOtp(email: email!);
                              }
                            : null,
                      ),
                    ],
                  ),
                  const GapWidget(size: 30),
                  PrimaryButton(
                    text: (context.watch<VisitorCubit>().state
                            is VisitorLoadingState)
                        ? '...'
                        : 'Submit',
                    onPressed: () {
                      String otp = _controllers
                          .map((controller) => controller.text)
                          .join();
                      if (otp.length != 6) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Color.fromARGB(255, 151, 130, 128),
                          content: Text('Please enter a valid OTP.'),
                          duration: Duration(seconds: 3),
                        ));
                      } else {
                        verifyEmail(context, otp);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
