import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppleyButtonWidget extends StatelessWidget {
  const AppleyButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  Padding(
      padding: REdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        height: 50.h,
        child: CustomElevatedButton(
          backgroundColor: theme.colorScheme.secondary,
          borderColor: theme.colorScheme.shadow,
          onPressed: () {
            // Action here
          },
          buttonTitle: AppText.appleyNow.tr(),
          titleStyle: TextStyle(
            color: theme.colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
