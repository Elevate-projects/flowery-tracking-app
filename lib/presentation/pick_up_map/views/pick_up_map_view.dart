import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/domain/entities/arguments/address_map_arguments.dart';
import 'package:flowery_tracking_app/presentation/pick_up_map/views/widgets/pick_up_map_view_body.dart';
import 'package:flowery_tracking_app/presentation/pick_up_map/views/widgets/pick_up_recenter_driver_button.dart';
import 'package:flowery_tracking_app/presentation/pick_up_map/views_model/pick_up_map_cubit.dart';
import 'package:flowery_tracking_app/presentation/pick_up_map/views_model/pick_up_map_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickUpMapView extends StatelessWidget {
  const PickUpMapView({super.key, required this.storeAddressMapArguments});
  final AddressMapArguments storeAddressMapArguments;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PickUpMapCubit>(
          create: (context) => getIt.get<PickUpMapCubit>()
            ..doIntent(
              intent: PickUpMapInitializationIntent(
                orderData: storeAddressMapArguments.orderData!,
              ),
            ),
        ),
        BlocProvider.value(value: storeAddressMapArguments.orderDetailsCubit),
      ],
      child: const Scaffold(
        body: PickUpMapViewBody(),
        floatingActionButton: PickUpRecenterDriverButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      ),
    );
  }
}
