import 'package:flowery_tracking_app/core/constants/app_images.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/onboarding/views/widgets/appley_button.dart';
import 'package:flowery_tracking_app/presentation/onboarding/views/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          const Row(
            children: [
              Expanded(
                flex: 1,
                child: Image(
                  image: AssetImage(AppImages.deliveryImage),
                ),
              ),
            ],
          ),
          const RSizedBox(height: 20),
          Padding(
            padding: REdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppText.welcome,
                  style: theme.textTheme.headlineMedium,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const RSizedBox(height: 24),
          const LoginButtonWidget(),
          const RSizedBox(height: 16),
          const AppleyButtonWidget(),
          const Spacer(),
          Padding(
            padding: REdgeInsets.only(bottom: 52),
            child: Text(
              AppText.appVersion,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.shadow,
              ),
            ),
          )
        ],
      ),
    );
  }
}
