import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedOrderDetailsAppBar extends StatelessWidget {
  const CompletedOrderDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 45.h,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: REdgeInsetsDirectional.only(start: 12, top: 16),
                child: Row(
                  children: [
                    const CustomBackArrow(),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        AppText.orderDetails.tr(),
                        style: theme.textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
