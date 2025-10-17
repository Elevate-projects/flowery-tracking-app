import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_addresses.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view/widgets/user_address_map_body.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_cubit.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAddressMapView extends StatelessWidget {
  const UserAddressMapView({super.key, required this.userAddressMapArguments});

  final UserAddressMapArguments userAddressMapArguments;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserAddressMapCubit>(
          create: (context) => getIt.get<UserAddressMapCubit>()
            ..doIntent(
              UserAddressMapInitializationIntent(
                orderData: userAddressMapArguments.orderData!,
              ),
            ),
        ),
        BlocProvider.value(value: userAddressMapArguments.orderDetailsCubit),
      ],
      child: Scaffold(
        body: UserAddressMapBody(orderData: userAddressMapArguments.orderData),
      ),
    );
  }
}
