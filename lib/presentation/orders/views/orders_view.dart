import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/orders_view_body.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_cubit.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersCubit>(
      create: (context) =>
          getIt.get<OrdersCubit>()
            ..doIntent(intent: const OrdersInitializationIntent()),
      child: const SafeArea(child: OrdersViewBody()),
    );
  }
}
