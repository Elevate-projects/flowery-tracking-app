import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersAppBar extends StatelessWidget {
  const OrdersAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          AppText.myOrders.tr(),
          style: theme.textTheme.headlineSmall,
        ),
      ),
    );
  }
}
