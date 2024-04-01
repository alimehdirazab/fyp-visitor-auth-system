import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/link_button.dart';
import 'package:fyp/presentation/widgets/otp_box.dart';
import 'package:fyp/presentation/widgets/primary_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  static const String routeName = "otpScreen";

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                style: TextStyles.body2.copyWith(color: Color(0xff565656)),
              ),
              const GapWidget(size: 30),
              Text('00:30',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20)),
              const GapWidget(size: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OtpBox(),
                  OtpBox(),
                  OtpBox(),
                  OtpBox(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t recieve the OTP? '),
                  LinkButton(text: 'RESEND', onPressed: () {})
                ],
              ),
              const GapWidget(size: 30),
              PrimaryButton(
                text: 'Submit',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
