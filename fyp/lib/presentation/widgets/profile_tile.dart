import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final bool editMode;
  final void Function()? onPressed;

  const ProfileTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.editMode = true,
    this.onPressed,
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
      trailing: editMode
          ? IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ))
          : null,
    );
  }
}
