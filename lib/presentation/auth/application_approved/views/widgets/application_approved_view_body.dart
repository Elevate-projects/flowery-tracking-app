import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_images.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationApprovedViewBody extends StatelessWidget {
  const ApplicationApprovedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const RSizedBox(height: 101),
        Image.asset(
          AppImages.applicationSubmitted,
          fit: BoxFit.contain,
          height: 115.h,
        ),
        const RSizedBox(height: 45),
        Expanded(
          child: RPadding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Text(
                  AppText.applicationApproved.tr(),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const RSizedBox(height: 16),
                Text(
                  AppText.applicationApprovedSubTitle.tr(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.shadow,
                  ),
                ),
                const RSizedBox(height: 24),
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(RouteNames.login);
                  },
                  buttonTitle: AppText.loginButton.tr(),
                ),
              ],
            ),
          ),
        ),
        Image.asset(
          width: ScreenUtil().screenWidth,
          AppImages.bottomWave,
          fit: BoxFit.contain,
          color: theme.colorScheme.primary.withValues(alpha: 0.4),
        ),
      ],
    );
  }
}
