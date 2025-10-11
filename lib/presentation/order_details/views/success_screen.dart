import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_images.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: RPadding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppImages.successImage, width: 150.h, height: 150.h),
            const RSizedBox(height: 32),
            Text(
              textAlign: TextAlign.center,
              AppText.thankYou.tr(),
              style: theme.textTheme.headlineLarge?.copyWith(
                color: Colors.green,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              AppText.theOrderDelivered.tr(),
              style: theme.textTheme.headlineLarge,
            ),
            const RSizedBox(height: 40),
            CustomElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  RouteNames.bottomNavigation,
                );
              },
              buttonTitle: AppText.done.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
