import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views/widgets/email_verification_app_bar.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views/widgets/email_verification_body.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_intent.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key, required this.email});

  final String email;

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Check if the widget is still in the tree
        Loaders.showSuccessMessage(
          message: AppText.resendOtp,
          context: context,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerificationScreenCubit>(
      create: (context) => getIt.get<VerificationScreenCubit>()
        ..doIntent(OnStartTimer())
        ..doIntent(InitializeVerificationFormIntent()),
      child: Scaffold(
        appBar: const EmailVerificationAppBar(),
        body: EmailVerificationBody(email: widget.email),
      ),
    );
  }
}
