import 'package:flutter/material.dart';

class VisitorUploadButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final void Function()? onTap;

  const VisitorUploadButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.text,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            color: Color(0xFF717171),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
