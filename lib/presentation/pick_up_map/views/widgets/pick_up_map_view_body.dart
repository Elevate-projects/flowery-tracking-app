import 'package:flowery_tracking_app/presentation/pick_up_map/views/widgets/pick_up_addresses_details.dart';
import 'package:flowery_tracking_app/presentation/pick_up_map/views/widgets/pick_up_map_section.dart';
import 'package:flowery_tracking_app/presentation/pick_up_map/views_model/pick_up_map_cubit.dart';
import 'package:flowery_tracking_app/presentation/pick_up_map/views_model/pick_up_map_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/back_circle.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickUpMapViewBody extends StatelessWidget {
  const PickUpMapViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<PickUpMapCubit, PickUpMapState>(
      listenWhen: (previous, current) => current.mapStatus.isFailure,
      listener: (context, state) {
        if (state.mapStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.mapStatus.error?.message ?? "",
            context: context,
          );
        }
      },
      child: const Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(child: PickUpMapSection()),
          Positioned.fill(child: PickUpAddressesDetails()),
          PositionedDirectional(
            top: 16,
            start: 16,
            child: SafeArea(child: BackCircle()),
          ),
        ],
      ),
    );
  }
}
