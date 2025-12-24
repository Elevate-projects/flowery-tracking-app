import 'package:flowery_tracking_app/presentation/user_address_map/view/widgets/map_addresses_details.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view/widgets/map_section.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_cubit.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/back_circle.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAddressMapBody extends StatelessWidget {
  const UserAddressMapBody({super.key, this.orderData});

  final dynamic orderData;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserAddressMapCubit, UserAddressMapState>(
      listenWhen: (previous, current) => current.mapStatus.isFailure,
      listener: (context, state) {
        if (state.mapStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.mapStatus.error?.message ?? "",
            context: context,
          );
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(child: MapSection(orderData: orderData)),

          Positioned.fill(child: MapAddressesDetails(orderData: orderData)),
          const PositionedDirectional(
            top: 16,
            start: 16,
            child: SafeArea(child: BackCircle()),
          ),
        ],
      ),
    );
  }
}
