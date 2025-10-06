import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/shimmer/order_details_app_bar_shimmer.dart';
import 'package:flowery_tracking_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsViewBodyShimmer extends StatelessWidget {
  const OrderDetailsViewBodyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const OrderDetailsAppBarShimmer(),
        SliverPadding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerEffect(
                  width: ScreenUtil().screenWidth,
                  height: 103.h,
                  radius: 10.r,
                ),
                const RSizedBox(height: 16),
                Text(
                  AppText.pickupAddress.tr(),
                  style: theme.textTheme.headlineSmall,
                ),
                const RSizedBox(height: 16),
                ShimmerEffect(
                  width: ScreenUtil().screenWidth,
                  height: 76.h,
                  radius: 10.r,
                ),
                const RSizedBox(height: 16),
                Text(
                  AppText.userAddress.tr(),
                  style: theme.textTheme.headlineSmall,
                ),
                const RSizedBox(height: 16),
                ShimmerEffect(
                  width: ScreenUtil().screenWidth,
                  height: 76.h,
                  radius: 10.r,
                ),
                const RSizedBox(height: 24),
                Text(
                  AppText.orderDetails.tr(),
                  style: theme.textTheme.headlineSmall,
                ),
                const RSizedBox(height: 16),
                ShimmerEffect(
                  width: ScreenUtil().screenWidth,
                  height: 76.h,
                  radius: 10.r,
                ),
                const RSizedBox(height: 8),
                ShimmerEffect(
                  width: ScreenUtil().screenWidth,
                  height: 76.h,
                  radius: 10.r,
                ),
                const RSizedBox(height: 8),
                ShimmerEffect(
                  width: ScreenUtil().screenWidth,
                  height: 76.h,
                  radius: 10.r,
                ),
                const RSizedBox(height: 24),
                ShimmerEffect(
                  width: ScreenUtil().screenWidth,
                  height: 51.h,
                  radius: 10.r,
                ),
                const RSizedBox(height: 24),
                ShimmerEffect(
                  width: ScreenUtil().screenWidth,
                  height: 51.h,
                  radius: 10.r,
                ),
                const RSizedBox(height: 4),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
