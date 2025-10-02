import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views/widgets/build_profile_reset_password_form.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/loading_dialog.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileResetPasswordBody extends StatelessWidget {
  const ProfileResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileResetPasswordCubit, ProfileResetPasswordState>(
      listener: (context, state) {
        switch (state.profileResetPasswordState.status) {
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
              message: AppText.passwordChanged,
              context: context,
            );
            break;
          case Status.failure:
            Navigator.pop(context);
            Loaders.showErrorMessage(
              message:
                  state.profileResetPasswordState.error?.message ??
                  AppText.error,
              context: context,
            );
            break;
        }
      },
      child: BlocBuilder<ProfileResetPasswordCubit, ProfileResetPasswordState>(
        builder: (context, state) {
          return const SingleChildScrollView(
            child: BuildProfileResetPasswordForm(),
          );
        },
      ),
    );
  }
}
