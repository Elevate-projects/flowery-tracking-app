import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickupBottomSheet extends StatelessWidget {
  final OrderEntity orderData;

  const PickupBottomSheet({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      maxChildSize: 0.38,
      minChildSize: 0.04,
      initialChildSize: 0.38,
      builder: (context, scrollController) {
        return Container(
          color: theme.scaffoldBackgroundColor,
          child: SingleChildScrollView(
            controller: scrollController,
            padding:  REdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 70.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                const RSizedBox(height: 25),
                Text(
                  AppText.pickupAddress.tr(),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: AppColors.gray
                  ),
                ),
                const RSizedBox(height: 8),
                OrderDetailsAddress(
                   title: orderData.store?.name ?? AppText.notProvided.tr(),
                  address: orderData.store?.address ?? AppText.notProvided.tr(),
                  phone: orderData.store?.phoneNumber ?? "",
                  image: orderData.store?.image ?? "",
                ),
                const RSizedBox(height: 25),
                Text(
                  AppText.userAddress.tr(),
                  style: theme.textTheme.titleSmall?.copyWith(
                      color: AppColors.gray
                  ),                ),
                const RSizedBox(height: 8),
                OrderDetailsAddress(
                  title:
                      "${orderData.user?.firstName ?? ''} ${orderData.user?.lastName ?? ''}",
                  image: orderData.user?.photo ?? "",
                  address:
                      "${orderData.shippingAddress?.city ?? ''}, ${orderData.shippingAddress?.street ?? ''}",
                  phone: orderData.user?.phone ?? "",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
