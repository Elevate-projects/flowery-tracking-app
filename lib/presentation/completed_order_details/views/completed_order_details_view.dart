import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_view_body.dart';
import 'package:flutter/material.dart';

class CompletedOrderDetailsView extends StatelessWidget {
  const CompletedOrderDetailsView({super.key, required this.orderData});
  final OrderEntity orderData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CompletedOrderDetailsViewBody(orderData: orderData),
      ),
    );
  }
}
