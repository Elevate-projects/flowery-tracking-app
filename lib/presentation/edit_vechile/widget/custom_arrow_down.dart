import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomArrowDown extends StatelessWidget {
  const CustomArrowDown({
    super.key,
    required this.onSelect,
  });

  final void Function(String) onSelect;

  final List<String> vehicleTypes = const [
    "Motor Cycle",
    "Compact",
    "Sedan",
    "Semi",
    "Sports",
    "SUV",
    "Truck",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: vehicleTypes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(vehicleTypes[index],
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    onTap: () {
                      onSelect(vehicleTypes[index],
                      );
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            );
          },
        );
      },
      child: Transform.rotate(
        angle: math.pi / -2,
        child: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).colorScheme.onSecondary,
          size: 26.r,
        ),
      ),
    );
  }
}

