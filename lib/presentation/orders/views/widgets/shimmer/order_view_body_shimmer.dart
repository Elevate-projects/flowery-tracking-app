import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/orders_app_bar.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/shimmer/recent_item_shimmer.dart';
import 'package:flowery_tracking_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderViewBodyShimmer extends StatelessWidget {
  const OrderViewBodyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RSizedBox(height: 16),
        const OrdersAppBar(),
        const RSizedBox(height: 16),
        RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: ShimmerEffect(width: 155.w, height: 70.h, radius: 10.r),
              ),
              const RSizedBox(width: 33),
              Expanded(
                child: ShimmerEffect(width: 155.w, height: 70.h, radius: 10.r),
              ),
            ],
          ),
        ),
        const RSizedBox(height: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    AppText.recentOrders.tr(),
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
              ),
              const RSizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  padding: REdgeInsets.symmetric(vertical: 8),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) => const RecentItemShimmer(),
                  separatorBuilder: (_, __) => const RSizedBox(height: 16),
                  itemCount: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
