import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views/widgets/login_app_bar.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views/widgets/login_view_body.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) =>
          getIt.get<LoginCubit>()
            ..doIntent(intent: InitializeLoginFormIntent()),
      child: const Scaffold(appBar: LoginAppBar(), body: LoginViewBody()),
    );
  }
}
