import 'package:flowery_tracking_app/presentation/home/views/widgets/shimmer/order_item_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersListShimmer extends StatelessWidget {
  const OrdersListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: REdgeInsets.symmetric(vertical: 20),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, __) => const OrderItemShimmer(),
      separatorBuilder: (_, __) => const RSizedBox(height: 24),
      itemCount: 22,
    );
  }
}
