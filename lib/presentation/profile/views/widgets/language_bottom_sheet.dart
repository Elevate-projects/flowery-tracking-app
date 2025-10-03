import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views/widgets/language_radio_group.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageBottomSheet extends StatelessWidget {
  final ProfileCubit profileCubit;
  final GlobalCubit globalCubit;

  const LanguageBottomSheet({
    super.key,
    required this.profileCubit,
    required this.globalCubit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RPadding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 80.r,
              height: 4.r,
              decoration: BoxDecoration(
                color: theme.colorScheme.shadow,
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
          ),
          const RSizedBox(height: 16),
          Text(
            key: const ValueKey(ConstKeys.changeLanguage),
            AppText.changeLanguage.tr(),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.primary,
            ),
          ),
          const RSizedBox(height: 16),
          LanguageRadioGroup(profileCubit: profileCubit, globalCubit: globalCubit),
        ],
      ),
    );
  }
}
