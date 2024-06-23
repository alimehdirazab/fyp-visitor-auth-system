import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisitorDetailsTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  const VisitorDetailsTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: Colors.grey,
        size: 40,
      ),
      title: Text(title),
      titleTextStyle: const TextStyle(color: Colors.grey),
      subtitle: Text(subtitle),
      subtitleTextStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
