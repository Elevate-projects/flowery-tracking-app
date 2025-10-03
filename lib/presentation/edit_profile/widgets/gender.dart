import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/enum.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/gender_cubit.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/gender_intent.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/gender_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class GenderSection extends StatelessWidget {
  const GenderSection({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final applyCubit = BlocProvider.of<GenderCubit>(context);
    return Row(
      children: [
        Text(
          AppText.gender,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.shadow,
          ),
        ),
        const RSizedBox(width: 40),
        BlocBuilder<GenderCubit, GenderState>(
          builder: (context, state) => Expanded(
            child: Row(
              children: [
                Flexible(
                  child: RadioMenuButton<Gender?>(
                    value: Gender.female,
                    groupValue: state.selectedGender,
                    onChanged: (value) {
                      if (value == null) return;
                      applyCubit.doIntent(
                        intent: ChangeGenderIntent(selectedGender: value),
                      );
                    },
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: Text(
                      AppText.genderFemale,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Flexible(
                  child: RadioMenuButton<Gender?>(
                    value: Gender.male,
                    groupValue: state.selectedGender,
                    onChanged: (value) {
                      if (value == null) return;
                      applyCubit.doIntent(
                        intent: ChangeGenderIntent(
                          selectedGender: value,
                        ),
                      );
                    },
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),

                    child: Text(
                      AppText.genderMale,
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