import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedOrderDetailsAddresses extends StatelessWidget {
  const CompletedOrderDetailsAddresses({super.key, required this.orderData});
  final OrderEntity orderData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppText.pickupAddress.tr(), style: theme.textTheme.headlineSmall),
        const RSizedBox(height: 16),
        CompletedOrderDetailsAddress(
          title: orderData.store?.name ?? AppText.notProvided.tr(),
          image: orderData.store?.image ?? "",
          address: orderData.store?.address ?? AppText.notProvided.tr(),
          phone: orderData.store?.phoneNumber ?? "",
        ),
        const RSizedBox(height: 16),
        Text(AppText.userAddress.tr(), style: theme.textTheme.headlineSmall),
        const RSizedBox(height: 16),
        CompletedOrderDetailsAddress(
          title: "${orderData.user?.firstName} ${orderData.user?.lastName}",
          image: orderData.user?.photo ?? "",
          address:
              "${orderData.shippingAddress?.city}, ${orderData.shippingAddress?.street}",
          phone: orderData.user?.phone ?? "",
        ),
      ],
    );
  }
}
