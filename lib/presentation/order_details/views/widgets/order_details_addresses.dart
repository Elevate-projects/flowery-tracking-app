import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_address.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsAddresses extends StatelessWidget {
  const OrderDetailsAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    final orderDetailsCubit = context.read<OrderDetailsCubit>();
    final theme = Theme.of(context);
    return BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.pickupAddress.tr(),
            style: theme.textTheme.headlineSmall,
          ),
          const RSizedBox(height: 16),
          OrderDetailsAddress(
            title:
                state.orderStatus.data?.store?.name ?? AppText.notProvided.tr(),
            image: state.orderStatus.data?.store?.image ?? "",
            address:
                state.orderStatus.data?.store?.address ??
                AppText.notProvided.tr(),
            phone: state.orderStatus.data?.store?.phoneNumber ?? "",
            onAddressTaped: () {
              // Navigate to Google maps
            },
          ),
          const RSizedBox(height: 16),
          Text(AppText.userAddress.tr(), style: theme.textTheme.headlineSmall),
          const RSizedBox(height: 16),
          OrderDetailsAddress(
            title:
                "${state.orderStatus.data?.user?.firstName} ${state.orderStatus.data?.user?.lastName}",
            image: state.orderStatus.data?.user?.photo ?? "",
            address:
                "${state.orderStatus.data?.shippingAddress?.city}, ${state.orderStatus.data?.shippingAddress?.street}",
            phone: state.orderStatus.data?.user?.phone ?? "",
            onAddressTaped: () {
              final orderData = state.orderStatus.data;
              Navigator.pushNamed(
                context,
                RouteNames.userAddressMap,
                arguments: UserAddressMapArguments(
                  orderData: orderData,
                  orderDetailsCubit: orderDetailsCubit,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class UserAddressMapArguments {
  final OrderEntity? orderData;
  final OrderDetailsCubit orderDetailsCubit;

  const UserAddressMapArguments({
    required this.orderData,
    required this.orderDetailsCubit,
  });
}
