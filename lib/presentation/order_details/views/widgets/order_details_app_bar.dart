import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OrderDetailsAppBar extends StatelessWidget {
  const OrderDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 94.h,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: REdgeInsetsDirectional.only(start: 32, top: 16),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    AppText.orderDetails.tr(),
                    style: theme.textTheme.headlineMedium,
                  ),
                ),
              ),
            ),
            const RSizedBox(height: 24),
            BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
              builder: (context, state) => RPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StepProgressIndicator(
                  totalSteps: 5,
                  currentStep: state.currentOrderState.index + 1,
                  selectedColor: theme.colorScheme.onSurface,
                  unselectedColor: AppColors.white[70]!,
                  roundedEdges: Radius.circular(6.r),
                  padding: 6.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
