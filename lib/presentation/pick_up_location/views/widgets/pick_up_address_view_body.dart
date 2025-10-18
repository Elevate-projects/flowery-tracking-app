import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views/widgets/map_section.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views/widgets/pickup_back_button.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views/widgets/pickup_bottom_sheet.dart';
import 'package:flutter/material.dart';

class PickUpAddressViewBody extends StatelessWidget {
  final OrderEntity orderData;

  const PickUpAddressViewBody({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapSection(orderData: orderData),
        const PickupBackButton(),
        PickupBottomSheet(orderData: orderData),
      ],
    );
  }
}
