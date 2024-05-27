import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool enablefield;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  const PrimaryTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.enablefield = true,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        enabled: enablefield,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}
