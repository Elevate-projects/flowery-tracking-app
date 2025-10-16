import 'package:flowery_tracking_app/core/constants/app_animations.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/order_status.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/orders_app_bar.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/recent_orders_list.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/shimmer/order_view_body_shimmer.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_cubit.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_state.dart';
import 'package:flowery_tracking_app/utils/loaders/animation_loader_widget.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state.driverOrdersStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.driverOrdersStatus.error?.message ?? "",
            context: context,
          );
        }
      },
      buildWhen: (previous, current) =>
          current.driverOrdersStatus.isLoading ||
          current.driverOrdersStatus.isSuccess,
      builder: (context, state) => state.driverOrdersStatus.isLoading
          ? const OrderViewBodyShimmer()
          : (state.driverOrdersStatus.data == null ||
                (state.driverOrdersStatus.data?.isEmpty ?? true))
          ? const AnimationLoaderWidget(
              text: AppText.emptyDeliveredOrdersMessage,
              animation: AppAnimations.emptyFile,
            )
          : const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RSizedBox(height: 16),
                OrdersAppBar(),
                RSizedBox(height: 16),
                OrderStatus(),
                RSizedBox(height: 16),
                Expanded(child: RecentOrdersList()),
              ],
            ),
    );
  }
}
