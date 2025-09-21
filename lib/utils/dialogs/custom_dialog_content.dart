import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialogContent extends StatelessWidget {
  const CustomDialogContent({super.key, this.actions, this.content});
  final List<Widget>? actions;
  final Widget? content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: REdgeInsets.symmetric(horizontal: 47.5),
      contentPadding: REdgeInsets.all(32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10.r),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: content,
      actions: actions,
    );
  }
}
