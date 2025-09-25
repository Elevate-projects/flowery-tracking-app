import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views/widgets/build_verification_form.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/loading_dialog.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerificationBody extends StatelessWidget {
  const EmailVerificationBody({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<VerificationScreenCubit, VerificationScreenState>(
          listenWhen: (prev, curr) =>
              prev.verifyCodeStatus != curr.verifyCodeStatus,
          listener: (context, state) {
            switch (state.verifyCodeStatus.status) {
              case Status.initial:
                break;
              case Status.loading:
                showLoadingDialog(
                  context,
                  color: Theme.of(context).colorScheme.primary,
                );
                break;
              case Status.success:
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                Navigator.pushReplacementNamed(
                  context,
                  RouteNames.resetPassword,
                  arguments: email,
                );
                break;
              case Status.failure:
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                Loaders.showErrorMessage(
                  message:
                      state.verifyCodeStatus.error?.message ?? AppText.error,
                  context: context,
                );
                break;
            }
          },
        ),
        BlocListener<VerificationScreenCubit, VerificationScreenState>(
          listenWhen: (prev, curr) =>
              prev.resendCodeStatus != curr.resendCodeStatus,
          listener: (context, state) {
            switch (state.resendCodeStatus.status) {
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
                  message: AppText.otpResentedSuccessfully.tr(),
                  context: context,
                );
                break;
              case Status.failure:
                Navigator.pop(context);
                Loaders.showErrorMessage(
                  message:
                      state.resendCodeStatus.error?.message ?? AppText.error,
                  context: context,
                );
                break;
            }
          },
        ),
      ],
      child: BlocBuilder<VerificationScreenCubit, VerificationScreenState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: BuildVerificationForm(email: email, isError: state.isError),
          );
        },
      ),
    );
  }
}
