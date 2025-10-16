import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_custom_container.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPaymentDetailsSection extends StatelessWidget {
  const OrderPaymentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RSizedBox(height: 24),
              OrderDetailsCustomContainer(
                title: AppText.total.tr(),
                suffixTitle:
                    "${AppText.egp.tr()} ${state.orderStatus.data?.totalPrice.toString()}",
              ),
              const RSizedBox(height: 24),
              OrderDetailsCustomContainer(
                title: AppText.paymentMethod.tr(),
                suffixTitle:
                    state.orderStatus.data?.paymentType ??
                    AppText.notProvided.tr(),
              ),
              const RSizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
