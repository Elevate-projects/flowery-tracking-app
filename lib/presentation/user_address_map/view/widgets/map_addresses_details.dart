import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapAddressesDetails extends StatelessWidget {
  const MapAddressesDetails({super.key, this.orderData});

  final dynamic orderData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      maxChildSize: 0.38.sp,
      minChildSize: 0.04.sp,
      initialChildSize: 0.38.sp,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: ListView(
            controller: scrollController, // important for drag sync
            padding: REdgeInsets.all(16),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      width: 70.w,
                      height: 4.h,
                      margin:  REdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),

                  // User Address Section
                  Text(
                    AppText.userAddress.tr(),
                    style: theme.textTheme.headlineSmall,
                  ),
                  const RSizedBox(height: 8),
                  OrderDetailsAddress(
                    title:
                        "${orderData?.user?.firstName ?? ''} ${orderData?.user?.lastName ?? ''}",
                    image: orderData?.user?.photo ?? "",
                    address:
                        "${orderData?.shippingAddress?.city ?? ''}, ${orderData?.shippingAddress?.street ?? ''}",
                    phone: orderData?.user?.phone ?? "",
                  ),
                  const RSizedBox(height: 16),
                  // Pickup Section
                  Text(
                    AppText.pickupAddress.tr(),
                    style: theme.textTheme.headlineSmall,
                  ),
                  const RSizedBox(height: 8),
                  OrderDetailsAddress(
                    title: orderData?.store?.name ?? AppText.notProvided.tr(),
                    image: orderData?.store?.image ?? "",
                    address:
                        orderData?.store?.address ?? AppText.notProvided.tr(),
                    phone: orderData?.store?.phoneNumber ?? "",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
