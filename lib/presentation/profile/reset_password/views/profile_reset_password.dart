import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views/widgets/profile_reset_password_app_bar.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views/widgets/profile_reset_password_body.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileResetPassword extends StatelessWidget {
  const ProfileResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileResetPasswordCubit>(
      create: (context) =>
          getIt.get<ProfileResetPasswordCubit>()
            ..doIntent(InitializeProfileResetPasswordFormIntent()),
      child: const Scaffold(
        appBar: ProfileResetPasswordAppBar(),
        body: ProfileResetPasswordBody(),
      ),
    );
  }
}
