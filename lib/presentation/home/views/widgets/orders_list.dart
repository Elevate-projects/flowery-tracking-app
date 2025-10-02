import 'package:flowery_tracking_app/core/constants/app_animations.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/order_item.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/shimmer/orders_list_shimmer.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_cubit.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_intent.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current.pendingOrdersStatus.isLoading ||
          current.pendingOrdersStatus.isSuccess,
      builder: (context, state) {
        if (state.pendingOrdersStatus.isSuccess) {
          return RefreshIndicator(
            onRefresh: () async => await homeCubit.doIntent(
              intent: const FetchDriverPendingOrdersIntent(),
            ),
            child: (state.pendingOrdersStatus.data?.isNotEmpty ?? false)
                ? ListView.separated(
                    padding: REdgeInsets.symmetric(vertical: 20),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) => OrderItem(
                      orderData: state.pendingOrdersStatus.data?[index],
                    ),
                    separatorBuilder: (_, __) => const RSizedBox(height: 24),
                    itemCount: state.pendingOrdersStatus.data!.length,
                  )
                : AnimationLoaderWidget(
                    text: AppText.emptyOrdersMessage,
                    animation: AppAnimations.emptyFile,
                    showAction: true,
                    actionWidget: RPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 62),
                      child: CustomElevatedButton(
                        onPressed: () {
                          homeCubit.doIntent(
                            intent: const FetchDriverPendingOrdersIntent(),
                          );
                        },
                        buttonTitle: AppText.reload,
                      ),
                    ),
                  ),
          );
        } else {
          return const OrdersListShimmer();
        }
      },
    );
  }
}
