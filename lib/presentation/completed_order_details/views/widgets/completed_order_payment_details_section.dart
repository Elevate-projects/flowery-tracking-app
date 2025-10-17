import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedOrderPaymentDetailsSection extends StatelessWidget {
  const CompletedOrderPaymentDetailsSection({
    super.key,
    required this.orderData,
  });
  final OrderEntity orderData;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RSizedBox(height: 24),
            OrderDetailsCustomContainer(
              title: AppText.total.tr(),
              suffixTitle:
                  "${AppText.egp.tr()} ${orderData.totalPrice.toString()}",
            ),
            const RSizedBox(height: 24),
            OrderDetailsCustomContainer(
              title: AppText.paymentMethod.tr(),
              suffixTitle: orderData.paymentType ?? AppText.notProvided.tr(),
            ),
            const RSizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
