import 'package:flutter/material.dart';
 import 'package:flowery_tracking_app/core/constants/app_colors.dart';

class TopBorderWidget extends StatelessWidget {
  const TopBorderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.white[60]!,
            width: 1,
          ),
        ),
      ),
    );
  }
}
