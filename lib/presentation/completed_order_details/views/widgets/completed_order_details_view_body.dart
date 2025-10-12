import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_addresses.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_app_bar.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_list.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_information.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_payment_details_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedOrderDetailsViewBody extends StatelessWidget {
  const CompletedOrderDetailsViewBody({super.key, required this.orderData});
  final OrderEntity orderData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const CompletedOrderDetailsAppBar(),
        SliverPadding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CompletedOrderInformation(orderData: orderData),
                const RSizedBox(height: 16),
                CompletedOrderDetailsAddresses(orderData: orderData),
                const RSizedBox(height: 24),
                Visibility(
                  visible:
                      orderData.orderItems != null &&
                      (orderData.orderItems?.isNotEmpty ?? false),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.orderDetails.tr(),
                        style: theme.textTheme.headlineSmall,
                      ),
                      const RSizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        CompletedOrderDetailsList(orderItems: orderData.orderItems),
        CompletedOrderPaymentDetailsSection(orderData: orderData),
      ],
    );
  }
}
