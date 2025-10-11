import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_images.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/address_item.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecentOrderItem extends StatelessWidget {
  const RecentOrderItem({super.key, required this.orderData});
  final OrderEntity? orderData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isCompleted =
        orderData?.state == CurrentOrderState.deliveredToTheUser.name;
    return InkWell(
      onTap: () {
        // Navigate to Order Details
      },
      borderRadius: BorderRadius.circular(10.r),
      highlightColor: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
      splashColor: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
      child: Container(
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
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                AppText.flowerOrder.tr(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSecondary,
                ),
              ),
            ),
            RPadding(
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
                        orderData?.orderNumber ?? "",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                AppText.pickupAddress.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.shadow,
                ),
              ),
            ),
            const RSizedBox(height: 8),
            AddressItem(
              title: orderData?.store?.name ?? AppText.notProvided.tr(),
              image: orderData?.store?.image ?? AppImages.dummyProfile,
              address: orderData?.store?.address ?? AppText.notProvided.tr(),
            ),
            const RSizedBox(height: 16),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                AppText.userAddress.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.shadow,
                ),
              ),
            ),
            const RSizedBox(height: 8),
            AddressItem(
              title:
                  "${orderData?.user?.firstName} ${orderData?.user?.lastName}",
              image: orderData?.user?.photo ?? AppImages.dummyProfile,
              address:
                  "${orderData?.shippingAddress?.city}, ${orderData?.shippingAddress?.street}",
            ),
            const RSizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
