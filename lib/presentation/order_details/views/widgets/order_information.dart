import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderInformation extends StatelessWidget {
  const OrderInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: ScreenUtil().screenWidth,
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppText.status.tr()} ${FloweryDriverMethodHelper.getCurrentOrderStateText(currentOrderState: state.currentOrderState.name)}",
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const RSizedBox(height: 8),
            Text(
              "${AppText.orderId.tr()} ${state.orderStatus.data?.orderNumber}",
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const RSizedBox(height: 8),
            Text(
              "Wed, 03 Sep 2024, 11:00 AM",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.shadow,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
