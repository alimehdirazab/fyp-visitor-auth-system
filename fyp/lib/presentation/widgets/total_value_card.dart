import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';

import 'package:fyp/presentation/widgets/gap_widget.dart';

class TotalValueCard extends StatelessWidget {
  final int total;
  final String value;
  final Color color;
  final IconData icon;
  const TotalValueCard({
    super.key,
    required this.total,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    late Size mq = MediaQuery.of(context).size;
    return SizedBox(
      width: mq.width * 0.45,
      child: Card(
        color: color,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                total.toString(),
                style: TextStyles.heading3.copyWith(
                  color: Colors.white,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.calendar,
                    color: Colors.white,
                  ),
                  Text(
                    ' Today',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              // const GapWidget(),
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(value,
                  style: TextStyles.body1
                      .copyWith(color: Colors.white, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
