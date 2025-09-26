import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/apply_app_bar.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/apply_view_body.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views_body/apply_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views_body/apply_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyView extends StatelessWidget {
  const ApplyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplyCubit>(
      create: (context) =>
          getIt.get<ApplyCubit>()
            ..doIntent(intent: const ApplyInitializationIntent()),
      child: const Scaffold(appBar: ApplyAppBar(), body: ApplyViewBody()),
    );
  }
}
