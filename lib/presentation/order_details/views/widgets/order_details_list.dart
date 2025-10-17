import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_item.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsList extends StatelessWidget {
  const OrderDetailsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
      builder: (context, state) => SliverPadding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.separated(
          itemBuilder: (context, index) => OrderDetailsItem(
            orderData:
                state.orderStatus.data?.orderItems?[index] ??
                const OrderItemEntity(),
          ),
          separatorBuilder: (context, index) => const RSizedBox(height: 8),
          itemCount: state.orderStatus.data?.orderItems?.length,
        ),
      ),
    );
  }
}
