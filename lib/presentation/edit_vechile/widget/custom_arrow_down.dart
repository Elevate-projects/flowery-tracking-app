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
    "676b31a45d05310ca82657ac",
    "676b31a45d05310ca82657ac",
    "676b31a45d05310ca82657ac"
  ];

  @override
  Widget build(BuildContext context) {
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
                    title: Text(vehicleTypes[index]),
                    onTap: () {
                      onSelect(vehicleTypes[index]);
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
        angle: 90 * 3.1415926535 / 60,
        child: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).colorScheme.onSecondary,
          size: 26.r,
        ),
      ),
    );
  }
}

