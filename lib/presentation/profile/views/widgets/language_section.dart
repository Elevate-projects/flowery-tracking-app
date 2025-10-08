import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
 import 'package:flowery_tracking_app/core/constants/widget_keys.dart';
 import 'package:flowery_tracking_app/presentation/profile/views/widgets/language_bottom_sheet.dart';
import 'package:flowery_tracking_app/presentation/profile/views/widgets/profile_navigation_item.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileCubit = BlocProvider.of<ProfileCubit>(context);
     return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return ProfileNavigationItem(
          key: const ValueKey(WidgetKeys.langItem),
          title: AppText.language.tr(),
          isIconWithTitle: true,
          prefixIconPath: AppIcons.translation,
          isSuffixArrow: false,
          suffixWidget: Text(
            state.selectedLanguage == Languages.arabic
                ? AppText.arabic.tr()
                : AppText.english.tr(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: theme.colorScheme.secondary,
              context: context,
              builder: (context) => BlocProvider.value(
                value: profileCubit,
                child: const LanguageBottomSheet(
                 ),
              ),
            );
          },
        );
      },
    );
  }
}
