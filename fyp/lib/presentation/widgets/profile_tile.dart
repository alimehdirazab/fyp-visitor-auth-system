import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;

  const ProfileTile({
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
      trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.edit,
            color: Theme.of(context).colorScheme.primary,
          )),
    );
  }
}
