import 'package:flowery_tracking_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsNavBarShimmer extends StatelessWidget {
  const OrderDetailsNavBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSecondary.withValues(alpha: 0.2),
            blurStyle: BlurStyle.outer,
            blurRadius: 4.r,
          ),
        ],
      ),
      child: ShimmerEffect(
        width: ScreenUtil().screenWidth,
        height: 48.h,
        radius: 100.r,
      ),
    );
  }
}
