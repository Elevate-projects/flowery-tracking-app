import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/recent_order_item.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_cubit.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentOrdersList extends StatelessWidget {
  const RecentOrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              AppText.recentOrders.tr(),
              style: theme.textTheme.headlineSmall,
            ),
          ),
        ),
        const RSizedBox(height: 8),
        BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) => Expanded(
            child: ListView.separated(
              padding: REdgeInsets.symmetric(vertical: 8, horizontal: 16),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) => RecentOrderItem(
                orderData: state.driverOrdersStatus.data![index],
              ),
              separatorBuilder: (_, __) => const RSizedBox(height: 16),
              itemCount: state.driverOrdersStatus.data!.length,
            ),
          ),
        ),
      ],
    );
  }
}
