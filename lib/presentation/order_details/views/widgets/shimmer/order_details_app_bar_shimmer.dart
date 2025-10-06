import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsAppBarShimmer extends StatelessWidget {
  const OrderDetailsAppBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 94.h,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: REdgeInsetsDirectional.only(start: 32, top: 16),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    AppText.orderDetails.tr(),
                    style: theme.textTheme.headlineMedium,
                  ),
                ),
              ),
            ),
            const RSizedBox(height: 24),
            RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(
                  5,
                  (index) => Expanded(
                    child: Padding(
                      padding: REdgeInsetsDirectional.only(end: 6.r),
                      child: ShimmerEffect(
                        width: 70.r,
                        height: 8.r,
                        radius: 6.r,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
