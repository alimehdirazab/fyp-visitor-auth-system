import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';

class GoogleButton extends StatelessWidget {
  final void Function()? onTap;
  const GoogleButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/google_icon.png'),
          const GapWidget(),
          const Text('Continue with Google')
        ],
      ),
    );
  }
}
