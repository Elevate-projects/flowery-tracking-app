import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_nav_bar.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_view_body.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/shimmer/order_details_nav_bar_shimmer.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/shimmer/order_details_view_body_shimmer.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_intent.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderDetailsCubit>(
      create: (context) =>
          getIt.get<OrderDetailsCubit>()
            ..doIntent(intent: const OrderDetailsInitializationIntent()),
      child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) => Scaffold(
          bottomNavigationBar: state.orderStatus.isLoading
              ? const OrderDetailsNavBarShimmer()
              : const OrderDetailsNavBar(),
          body: SafeArea(
            child: state.orderStatus.isLoading
                ? const OrderDetailsViewBodyShimmer()
                : const OrderDetailsViewBody(),
          ),
        ),
      ),
    );
  }
}
