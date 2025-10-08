import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_addresses.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_app_bar.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_list.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_information.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_payment_details_section.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsViewBody extends StatelessWidget {
  const OrderDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<OrderDetailsCubit, OrderDetailsState>(
      listener: (context, state) {
        if (state.updateOrderStateStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.updateOrderStateStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.orderStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.orderStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.openPhoneStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.openPhoneStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.openWhatsappStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.openWhatsappStatus.error?.message ?? "",
            context: context,
          );
        }
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const OrderDetailsAppBar(),
          SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OrderInformation(),
                  const RSizedBox(height: 16),
                  const OrderDetailsAddresses(),
                  const RSizedBox(height: 24),
                  Text(
                    AppText.orderDetails.tr(),
                    style: theme.textTheme.headlineSmall,
                  ),
                  const RSizedBox(height: 16),
                ],
              ),
            ),
          ),
          const OrderDetailsList(),
          const OrderPaymentDetailsSection(),
        ],
      ),
    );
  }
}
