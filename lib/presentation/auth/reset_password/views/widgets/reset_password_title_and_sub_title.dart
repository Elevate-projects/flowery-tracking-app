import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordTitleAndSubTitle extends StatelessWidget {
  const ResetPasswordTitleAndSubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(AppText.resetPasswordTitle.tr(), style: theme.headlineSmall),
        const RSizedBox(height: 15),
        Text(
          textAlign: TextAlign.center,
          AppText.resetPasswordSubTitle.tr(),
          style: theme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
      ],
    );
  }
}
