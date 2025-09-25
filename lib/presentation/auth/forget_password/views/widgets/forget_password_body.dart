import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views/widgets/build_forget_password_form.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/loading_dialog.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ForgetPasswordAndResendCodeCubit>(context);
    return BlocListener<
      ForgetPasswordAndResendCodeCubit,
      ForgetPasswordAndResendCodeState
    >(
      listener: (context, state) {
        switch (state.forgetPasswordAndResendCodeStatus.status) {
          case Status.initial:
            break;
          case Status.loading:
            showLoadingDialog(
              context,
              color: Theme.of(context).colorScheme.primary,
            );
            break;
          case Status.success:
            Navigator.pop(context);
            Loaders.showSuccessMessage(
              message: AppText.resendOtp,
              context: context,
            );
            Navigator.pushNamed(
              context,
              RouteNames.emailVerification,
              arguments: cubit.emailController.text.trim(),
            );
          case Status.failure:
            Navigator.pop(context);
            Loaders.showErrorMessage(
              message:
                  state.forgetPasswordAndResendCodeStatus.error?.message ??
                  AppText.error,
              context: context,
            );
            break;
        }
      },
      child: const SingleChildScrollView(child: BuildForgetPasswordForm()),
    );
  }
}
