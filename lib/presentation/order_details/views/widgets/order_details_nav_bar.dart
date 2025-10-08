import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_intent.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/loading_button.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsNavBar extends StatelessWidget {
  const OrderDetailsNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final orderDetailsCubit = BlocProvider.of<OrderDetailsCubit>(context);
    final theme = Theme.of(context);
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSecondary.withValues(alpha: 0.2),
            blurStyle: BlurStyle.outer,
            blurRadius: 4.r,
          ),
        ],
      ),
      child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) => state.updateOrderStateStatus.isLoading
            ? const Column(
                mainAxisSize: MainAxisSize.min,
                children: [LoadingButton()],
              )
            : CustomElevatedButton(
                onPressed: state.currentOrderState.index != 4
                    ? () async {
                        await orderDetailsCubit.doIntent(
                          intent: const UpdateOrderStateIntent(),
                        );
                      }
                    : null,
                buttonTitle:
                    FloweryDriverMethodHelper.getCurrentOrderStateButtonTitle(
                      currentOrderState: state.currentOrderState.name,
                    ),
              ),
      ),
    );
  }
}
