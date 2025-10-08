import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views/widgets/pick_up_address_view_body.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views_model/pick_up_address_cubit.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views_model/pick_up_address_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickUpAddressView extends StatelessWidget {
  final OrderEntity orderData;

  const PickUpAddressView({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PickUpAddressCubit>(
          create: (context) => getIt.get<PickUpAddressCubit>()
            ..doIntent(
              PickupAddressInitIntent(orderData: orderData),
            ),
        ),
        BlocProvider<OrderDetailsCubit>(
          create: (context) => getIt<OrderDetailsCubit>(),
        ),
      ],
      child: Scaffold(body: PickUpAddressViewBody(orderData: orderData)),
    );
  }
}
