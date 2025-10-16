import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_colors.dart';
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
    return Stack(
      children: [
        // Main content
        Padding(
          padding:  REdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RSizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset(AppImages.applicationSubmitted),
                ),
                const RSizedBox(height: 44),
                FittedBox(
                  child: Text(
                    key: const Key('applicationApprovedTitle'),
                    AppText.applicationApproved.tr(),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const RSizedBox(height: 16),
                Text(
                  key: const Key('applicationApprovedSubTitle'),
                  AppText.applicationApprovedSubTitle.tr(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.black[30],
                  ),
                ),
                const RSizedBox(height: 24),
                CustomElevatedButton(
                  key: const Key('loginApproveButton'),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(RouteNames.login);
                  },
                  buttonTitle: AppText.loginButton.tr(),
                ),
                const RSizedBox( height: 84),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: RSizedBox(
            height: 321.h,
            child: Image.asset(
              AppImages.bottomWave,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}