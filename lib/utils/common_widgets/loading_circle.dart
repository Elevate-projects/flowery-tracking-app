import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({super.key, this.width, this.height, this.circleColor});
  final double? width, height;
  final Color? circleColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? 24.r,
        height: height ?? 24.r,
        child: CircularProgressIndicator(color: circleColor ?? AppColors.white),
      ),
    );
  }
}
