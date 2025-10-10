import 'package:flowery_tracking_app/presentation/user_address_map/view/widgets/map_addresses_details.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view/widgets/map_section.dart';
import 'package:flutter/material.dart';

class UserAddressMapBody extends StatelessWidget {
  const UserAddressMapBody({super.key, this.orderData});

  final dynamic orderData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: MapSection(orderData: orderData)),

        Positioned.fill(child: MapAddressesDetails(orderData: orderData)),
      ],
    );
  }
}
