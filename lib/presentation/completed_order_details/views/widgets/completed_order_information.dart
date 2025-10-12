import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompletedOrderInformation extends StatelessWidget {
  const CompletedOrderInformation({super.key, required this.orderData});
  final OrderEntity orderData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isCompleted =
        orderData.state == CurrentOrderState.deliveredToTheUser.name;
    return RPadding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                SvgPicture.asset(
                  isCompleted ? AppIcons.completed : AppIcons.canceled,
                  fit: BoxFit.contain,
                ),
                const RSizedBox(width: 4),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      isCompleted
                          ? AppText.completed.tr()
                          : AppText.canceled.tr(),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: isCompleted
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.error,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const RSizedBox(width: 12),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                orderData.orderNumber ?? "",
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
