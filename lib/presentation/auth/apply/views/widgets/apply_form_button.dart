import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_intent.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyFormButton extends StatelessWidget {
  const ApplyFormButton({super.key});

  @override
  Widget build(BuildContext context) {
    final applyCubit = BlocProvider.of<ApplyCubit>(context);
    return CustomElevatedButton(
      key: const Key("applyFormButton"),
      onPressed: () async {
        await applyCubit.doIntent(intent: const ApplyFormIntent());
      },
      buttonTitle: AppText.continueText,
    );
  }
}
