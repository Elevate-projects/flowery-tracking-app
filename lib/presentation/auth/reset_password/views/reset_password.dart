import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views/widgets/reset_password_app_bar.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views/widgets/reset_password_body.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_intent.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Check if the widget is still in the tree
        Loaders.showSuccessMessage(
          message: AppText.verificationSuccess,
          context: context,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordCubit>(
      create: (context) =>
          getIt.get<ResetPasswordCubit>()
            ..doIntent(InitializeResetPasswordFormIntent()),
      child: Scaffold(
        appBar: const ResetPasswordAppBar(),
        body: ResetPasswordBody(email: widget.email),
      ),
    );
  }
}
