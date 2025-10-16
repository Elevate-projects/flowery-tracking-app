import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderSection extends StatelessWidget {

  GenderSection({super.key});

  final ValueNotifier<Gender?> selectedGender = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          AppText.gender.tr(),
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.shadow,
          ),
        ),
        const RSizedBox(width: 40),
        Expanded(
          child: ValueListenableBuilder<Gender?>(
            valueListenable: selectedGender,
            builder: (context, gender, _) {
              return Row(
                children: [
                  Flexible(
                    child: RadioMenuButton<Gender?>(
                      value: Gender.female,
                      groupValue: gender,
                      onChanged: (value) {
                        if (value != null) selectedGender.value = value;
                      },
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: Text(
                        AppText.genderFemale.tr(),
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
                      groupValue: gender,
                      onChanged: (value) {
                        if (value != null) selectedGender.value = value;
                      },
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: Text(
                        AppText.genderMale.tr(),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
