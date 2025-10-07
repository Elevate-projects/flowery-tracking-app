import 'package:flowery_tracking_app/presentation/home/views/widgets/shimmer/address_item_shimmer.dart';
import 'package:flowery_tracking_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentItemShimmer extends StatelessWidget {
  const RecentItemShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: REdgeInsets.symmetric(horizontal: 16),
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.25),
            blurStyle: BlurStyle.outer,
            blurRadius: 4.r,
          ),
        ],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerEffect(width: 80.w, height: 14.h),
          RPadding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: ShimmerEffect(width: 50, height: 16),
                ),
                RSizedBox(width: 0.35.sw),
                const Expanded(
                  flex: 1,
                  child: ShimmerEffect(width: 50, height: 16),
                ),
              ],
            ),
          ),
          ShimmerEffect(width: 85.w, height: 12.h),
          const RSizedBox(height: 8),
          const AddressItemShimmer(),
          const RSizedBox(height: 16),
          ShimmerEffect(width: 85.w, height: 12.h),
          const RSizedBox(height: 8),
          const AddressItemShimmer(),
          const RSizedBox(height: 16),
        ],
      ),
    );
  }
}
