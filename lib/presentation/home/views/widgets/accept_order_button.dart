import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/accept_order/accept_order_request_entity.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_cubit.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_intent.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcceptOrderButton extends StatelessWidget {
  const AcceptOrderButton({super.key, required this.orderData});
  final OrderEntity orderData;
  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) =>
          (state.acceptOrderStatus.isLoading &&
              state.currentOrderID == orderData.id)
          ? LoadingButton(
              height: 36.h,
              loadingCircleWidth: 16.r,
              loadingCircleHeight: 16.r,
            )
          : CustomElevatedButton(
              onPressed: () async {
                await homeCubit.doIntent(
                  intent: AcceptOrderIntent(
                    request: AcceptOrderRequestEntity(
                      orderId: orderData.id ?? "",
                      orderData: orderData,
                    ),
                  ),
                );
              },
              buttonTitle: AppText.accept,
              height: 36.h,
            ),
    );
  }
}
