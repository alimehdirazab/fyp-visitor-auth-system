import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/presentation/widgets/visitor_details_tile.dart';

class VisitorDetailsPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  const VisitorDetailsPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Visitor Details'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Visitor Details', style: TextStyles.heading2),
              const SizedBox(
                height: 16,
              ),
              VisitorDetailsTile(
                leadingIcon: Icons.person,
                title: 'Name',
                subtitle: name,
              ),
              VisitorDetailsTile(
                leadingIcon: Icons.email,
                title: 'Email',
                subtitle: email,
              ),
              VisitorDetailsTile(
                leadingIcon: Icons.phone,
                title: 'Phone',
                subtitle: phone,
              )
            ],
          ),
        ));
  }
}
