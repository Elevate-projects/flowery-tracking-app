import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PositionedDirectionalWidget extends StatelessWidget {
  const PositionedDirectionalWidget({
    super.key,
   });


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PositionedDirectional(
      end: -2.r,
      top: -4.r,
      child: Container(
        width: 16.r,
        height: 16.r,
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          shape: BoxShape.circle,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "3",
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
