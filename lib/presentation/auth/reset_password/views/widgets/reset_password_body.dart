import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views/widgets/build_reset_password_form.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/loading_dialog.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        switch (state.resetPasswordState.status) {
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
            Navigator.pushReplacementNamed(context, RouteNames.login);
            Loaders.showSuccessMessage(
              message: AppText.passwordRested,
              context: context,
            );
            break;
          case Status.failure:
            Navigator.pop(context);
            Loaders.showErrorMessage(
              message: state.resetPasswordState.error?.message ?? AppText.error,
              context: context,
            );
            break;
        }
      },
      child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: BuildResetPasswordForm(email: email),
          );
        },
      ),
    );
  }
}
