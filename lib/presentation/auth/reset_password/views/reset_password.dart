import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views/widgets/reset_password_app_bar.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views/widgets/reset_password_body.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordCubit>(
      create: (context) =>
          getIt.get<ResetPasswordCubit>()
            ..doIntent(InitializeResetPasswordFormIntent()),
      child: Scaffold(
        appBar: const ResetPasswordAppBar(),
        body: ResetPasswordBody(email: email),
      ),
    );
  }
}
