import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomElevatedButton(
        height: 50.h,
        backgroundColor: theme.colorScheme.secondary,
        borderColor: theme.colorScheme.shadow,
        onPressed: () {
          Navigator.of(context).pushNamed(RouteNames.apply);
        },
        buttonTitle: AppText.applyNow,
        titleStyle: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: theme.colorScheme.onSecondary),
      ),
    );
  }
}
