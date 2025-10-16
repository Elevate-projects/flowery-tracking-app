import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/order_status_item.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_cubit.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) => Row(
        children: [
          Expanded(
            child: OrderStatusItem(
              ordersNumber: state.canceledOrders,
              orderStatus: AppText.canceled,
              statusIcon: AppIcons.canceled,
            ),
          ),
          const RSizedBox(width: 33),
          Expanded(
            child: OrderStatusItem(
              ordersNumber: state.completedOrders,
              orderStatus: AppText.completed,
              statusIcon: AppIcons.completed,
            ),
          ),
        ],
      ),
    );
  }
}
