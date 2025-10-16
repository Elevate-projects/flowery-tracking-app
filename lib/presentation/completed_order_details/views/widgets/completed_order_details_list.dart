import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedOrderDetailsList extends StatelessWidget {
  const CompletedOrderDetailsList({super.key, required this.orderItems});
  final List<OrderItemEntity>? orderItems;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: orderItems != null && (orderItems?.isNotEmpty ?? false),
      child: SliverPadding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.separated(
          itemBuilder: (context, index) => OrderDetailsItem(
            orderData: orderItems?[index] ?? const OrderItemEntity(),
          ),
          separatorBuilder: (context, index) => const RSizedBox(height: 8),
          itemCount: orderItems?.length ?? 0,
        ),
      ),
    );
  }
}
