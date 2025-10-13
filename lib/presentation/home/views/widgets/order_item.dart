import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_images.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/accept_order_button.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/address_item.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/reject_order_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.orderData});
  final OrderEntity? orderData;
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
          Text(
            AppText.flowerOrder.tr(),
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const RSizedBox(height: 16),
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
            title: "${orderData?.user?.firstName} ${orderData?.user?.lastName}",
            image: orderData?.user?.photo ?? AppImages.dummyProfile,
            address:
                "${orderData?.shippingAddress?.city}, ${orderData?.shippingAddress?.street}",
          ),
          const RSizedBox(height: 16),
          Row(
            children: [
              RSizedBox(
                width: 70,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "${AppText.egp.tr()} ${orderData?.totalPrice.toString() ?? AppText.notProvided.tr()}",
                  ),
                ),
              ),
              const RSizedBox(width: 8),
              Expanded(child: RejectOrderButton(orderId: orderData?.id ?? "")),
              const RSizedBox(width: 8),
              Expanded(child: AcceptOrderButton(orderData: orderData!)),
            ],
          ),
        ],
      ),
    );
  }
}
