import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderSection extends StatelessWidget {
  const GenderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final applyCubit = BlocProvider.of<ApplyCubit>(context);
    return Row(
      children: [
        Text(
          AppText.gender,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.shadow,
          ),
        ),
        const RSizedBox(width: 40),
        BlocBuilder<ApplyCubit, ApplyState>(
          builder: (context, state) => Expanded(
            child: Row(
              children: [
                Flexible(
                  child: RadioMenuButton<Gender>(
                    value: Gender.female,
                    groupValue: state.selectedGender,
                    onChanged: (value) {
                      applyCubit.doIntent(
                        intent: ChangeGenderIntent(selectedGender: value),
                      );
                    },
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: Text(
                      AppText.female.tr(),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Flexible(
                  child: RadioMenuButton<Gender>(
                    value: Gender.male,
                    groupValue: state.selectedGender,
                    onChanged: (value) {
                      applyCubit.doIntent(
                        intent: ChangeGenderIntent(selectedGender: value),
                      );
                    },
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),

                    child: Text(
                      AppText.male.tr(),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
