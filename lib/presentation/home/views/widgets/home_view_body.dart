import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/orders_list.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_cubit.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_state.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          current.acceptOrderStatus.isFailure ||
          current.acceptOrderStatus.isSuccess ||
          current.pendingOrdersStatus.isFailure ||
          current.pendingOrdersStatus.isSuccess,
      listener: (context, state) {
        if (state.pendingOrdersStatus.isFailure) {
          Loaders.showErrorMessage(
            message:
                state.pendingOrdersStatus.error?.message ??
                AppText.unexpectedError,
            context: context,
          );
        } else if (state.pendingOrdersStatus.isSuccess &&
            state.isReloading == true) {
          Loaders.showSuccessMessage(
            message: AppText.reloadedOrdersMessage,
            context: context,
          );
        } else if (state.acceptOrderStatus.isFailure) {
          Loaders.showErrorMessage(
            message:
                state.acceptOrderStatus.error?.message ??
                AppText.unexpectedError,
            context: context,
          );
        } else if (state.acceptOrderStatus.isSuccess) {
          // Delete the Loader and navigate to Order Details screen
          // Navigator.of(context).pushReplacementNamed(RouteNames.orderDetails);
          Loaders.showSuccessMessage(
            message: "The Order has been accepted Successfully",
            context: context,
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RSizedBox(height: 16),
          RPadding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppText.floweryRider.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontFamily: "IM Fell English",
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const RSizedBox(height: 10),
          const Expanded(child: OrdersList()),
        ],
      ),
    );
  }
}
