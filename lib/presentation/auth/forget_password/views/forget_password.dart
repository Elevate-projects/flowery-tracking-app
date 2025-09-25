import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views/widgets/forget_password_app_bar.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views/widgets/forget_password_body.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgetPasswordAndResendCodeCubit>(
      create: (context) =>
          getIt.get<ForgetPasswordAndResendCodeCubit>()
            ..doIntent(const InitializeForgetPasswordFormIntent()),
      child: const Scaffold(
        appBar: ForgetPasswordAppBar(),
        body: ForgetPasswordBody(),
      ),
    );
  }
}
