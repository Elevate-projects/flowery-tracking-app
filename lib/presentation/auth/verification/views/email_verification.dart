import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views/widgets/email_verification_app_bar.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views/widgets/email_verification_body.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<VerificationScreenCubit>(),
      child: Scaffold(
        appBar: const EmailVerificationAppBar(),
        body: EmailVerificationBody(email: email),
      ),
    );
  }
}
