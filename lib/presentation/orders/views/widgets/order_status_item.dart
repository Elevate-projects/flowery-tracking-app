import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderStatusItem extends StatelessWidget {
  const OrderStatusItem({
    super.key,
    required this.ordersNumber,
    required this.orderStatus,
    required this.statusIcon,
  });
  final String ordersNumber;
  final String orderStatus;
  final String statusIcon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: REdgeInsets.symmetric(horizontal: 16),
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(ordersNumber, style: theme.textTheme.headlineSmall),
          ),
          const RSizedBox(height: 8),
          Row(
            children: [
              SvgPicture.asset(statusIcon, fit: BoxFit.contain),
              const RSizedBox(width: 4),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    orderStatus.tr(),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
