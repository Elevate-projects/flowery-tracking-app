import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_address.dart';
import 'package:flowery_tracking_app/presentation/pick_up_map/views_model/pick_up_map_cubit.dart';
import 'package:flowery_tracking_app/presentation/pick_up_map/views_model/pick_up_map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickUpAddressesDetails extends StatelessWidget {
  const PickUpAddressesDetails({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      maxChildSize: 0.34.sp,
      minChildSize: 0.04.sp,
      initialChildSize: 0.04.sp,
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
            controller: scrollController,
            padding: REdgeInsets.all(16),
            children: [
              BlocBuilder<PickUpMapCubit, PickUpMapState>(
                builder: (context, state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle
                    Center(
                      child: Container(
                        width: 70.w,
                        height: 4.h,
                        margin: REdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),

                    // Pickup Section
                    Text(
                      AppText.pickupAddress.tr(),
                      style: theme.textTheme.headlineSmall,
                    ),
                    const RSizedBox(height: 8),
                    OrderDetailsAddress(
                      title:
                          state.orderData?.store?.name ??
                          AppText.notProvided.tr(),
                      image: state.orderData?.store?.image ?? "",
                      address:
                          state.orderData?.store?.address ??
                          AppText.notProvided.tr(),
                      phone: state.orderData?.store?.phoneNumber ?? "",
                    ),
                    const RSizedBox(height: 16),
                    // User Address Section
                    Text(
                      AppText.userAddress.tr(),
                      style: theme.textTheme.headlineSmall,
                    ),
                    const RSizedBox(height: 8),
                    OrderDetailsAddress(
                      title:
                          "${state.orderData?.user?.firstName ?? ''} ${state.orderData?.user?.lastName ?? ''}",
                      image: state.orderData?.user?.photo ?? "",
                      address:
                          "${state.orderData?.shippingAddress?.city ?? ''}, ${state.orderData?.shippingAddress?.street ?? ''}",
                      phone: state.orderData?.user?.phone ?? "",
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
