import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_cubit.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_intent.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RejectOrderButton extends StatelessWidget {
  const RejectOrderButton({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return CustomElevatedButton(
      onPressed: () {
        homeCubit.doIntent(intent: RejectOrderIntent(orderId: orderId));
      },
      buttonTitle: AppText.reject,
      borderColor: theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.secondary,
      titleStyle: Theme.of(
        context,
      ).textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary),
      height: 36.h,
    );
  }
}
