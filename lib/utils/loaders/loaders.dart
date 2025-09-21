import 'package:another_flushbar/flushbar.dart';
import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Loaders {
  static void showSuccessMessage({
    Widget? title,
    required String message,
    int secondsDuration = 3,
    required BuildContext context,
  }) {
    Flushbar(
      titleText: title,
      messageText: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.start,
      ),
      icon: Icon(Icons.info_outline_rounded, color: Colors.white, size: 28.r),
      backgroundColor: Colors.green,
      boxShadows: const [
        BoxShadow(
          color: Colors.green,
          blurRadius: 5,
          blurStyle: BlurStyle.outer,
        ),
      ],
      margin: REdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8.r),
      duration: Duration(seconds: secondsDuration),
      leftBarIndicatorColor: Colors.lightGreen,
    ).show(context);
  }

  static void showWarningMessage({
    Widget? title,
    required String message,
    int secondsDuration = 3,
    required BuildContext context,
  }) {
    Flushbar(
      titleText: title,
      messageText: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.start,
      ),
      icon: Icon(Icons.warning_amber_outlined, color: Colors.white, size: 28.r),
      backgroundColor: Colors.orangeAccent,
      boxShadows: const [
        BoxShadow(
          color: Colors.orangeAccent,
          blurRadius: 5,
          blurStyle: BlurStyle.outer,
        ),
      ],
      margin: REdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8.r),
      duration: Duration(seconds: secondsDuration),
      leftBarIndicatorColor: Colors.orange,
    ).show(context);
  }

  static void showErrorMessage({
    Widget? title,
    required String message,
    int secondsDuration = 3,
    required BuildContext context,
  }) {
    Flushbar(
      titleText: title,
      messageText: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.start,
      ),
      icon: Icon(Icons.info_outline_rounded, color: Colors.white, size: 28.r),
      backgroundColor: Colors.redAccent,
      boxShadows: const [
        BoxShadow(
          color: Colors.redAccent,
          blurRadius: 5,
          blurStyle: BlurStyle.outer,
        ),
      ],
      margin: REdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8.r),
      duration: Duration(seconds: secondsDuration),
      leftBarIndicatorColor: Colors.red,
    ).show(context);
  }
}
