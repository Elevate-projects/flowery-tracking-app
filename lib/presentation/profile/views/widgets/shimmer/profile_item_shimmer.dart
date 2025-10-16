import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flowery_tracking_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileItemShimmer extends StatelessWidget {
  const ProfileItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: REdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,

        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha((0.1 * 255).round()),
            blurRadius: 10,
          ),
        ],
      ),
      child: ShimmerEffect(
        width: ScreenUtil().screenWidth,
        height: 108.h,
        radius: 10.r,
      ),
    );
  }
}
