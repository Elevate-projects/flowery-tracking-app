import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleAndSubtitleOfVerification extends StatelessWidget {
  const TitleAndSubtitleOfVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          AppText.emailVerificationTitle.tr(),
          style: theme.textTheme.headlineSmall,
        ),
        const RSizedBox(height: 15),
        Text(
          textAlign: TextAlign.center,
          AppText.emailVerificationSubTitle.tr(),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.shadow,
          ),
        ),
      ],
    );
  }
}
