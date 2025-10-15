import 'package:flowery_tracking_app/core/constants/app_animations.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/apply_form.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/apply_form_button.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_state.dart';
import 'package:flowery_tracking_app/utils/loaders/full_screen_loader.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplyViewBody extends StatelessWidget {
  const ApplyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<ApplyCubit, ApplyState>(
      listener: (context, state) {
        if (state.vehicleStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.vehicleStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.countryStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.countryStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.applyStatus.isLoading) {
          FullScreenLoader.openLoadingDialog(
            text: AppText.signingYouUpMessage,
            animation: AppAnimations.loadingMobile,
            context: context,
          );
        } else if (state.applyStatus.isFailure) {
          FullScreenLoader.stopLoading(context: context);
          Loaders.showErrorMessage(
            message: state.applyStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.applyStatus.isSuccess) {
          FullScreenLoader.stopLoading(context: context);
          // Navigate to the next screen
        }
      },
      child: SingleChildScrollView(
        key: const Key("applyViewBodyScrollView"),
        child: RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RSizedBox(height: 24),
              Text(AppText.welcomeApply, style: theme.textTheme.headlineMedium),
              const RSizedBox(height: 8),
              Text(
                AppText.applyWelcomeMessage,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.shadow,
                ),
              ),
              const RSizedBox(height: 32),
              const ApplyForm(),
              const RSizedBox(height: 25),
              const ApplyFormButton(),
              const RSizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}
