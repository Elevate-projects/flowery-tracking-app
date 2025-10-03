import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/bottom_sheet_selection_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageRadioGroup extends StatelessWidget {
  final ProfileCubit profileCubit;
  final GlobalCubit globalCubit;

  const LanguageRadioGroup({
    super.key,
    required this.profileCubit,
    required this.globalCubit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return RadioGroup<Languages>(
          groupValue: state.selectedLanguage,
          onChanged: (Languages? value) async {
            await profileCubit.doIntent(
              ToggleLanguageIntent(
                globalCubit: globalCubit,
                newSelectedLanguage: value ?? state.selectedLanguage,
              ),
            );
            if (context.mounted) {
              context.setLocale(
                globalCubit.isArLanguage
                    ? const Locale("ar")
                    : const Locale("en"),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BottomSheetSelectionItem(
                key: const ValueKey(ConstKeys.bottomSheetSelectionItem),
                itemTitle: AppText.english,
                radioItem: Radio<Languages>(
                  key: const ValueKey(ConstKeys.radioItemEn),
                  value: Languages.english,
                  activeColor: theme.colorScheme.primary,
                  toggleable: true,
                ),
                onTap: () async {
                  await profileCubit.doIntent(
                    ToggleLanguageIntent(
                      globalCubit: globalCubit,
                      newSelectedLanguage: Languages.english,
                    ),
                  );
                  if (context.mounted) {
                    context.setLocale(const Locale("en"));
                  }
                },
              ),
              const RSizedBox(height: 16),
              BottomSheetSelectionItem(
                itemTitle: AppText.arabic,
                radioItem: Radio<Languages>(
                  key: const ValueKey(ConstKeys.radioItemAr),
                  value: Languages.arabic,
                  activeColor: theme.colorScheme.primary,
                  toggleable: true,
                ),
                onTap: () async {
                  await profileCubit.doIntent(
                    ToggleLanguageIntent(
                      globalCubit: globalCubit,
                      newSelectedLanguage: Languages.arabic,
                    ),
                  );
                  if (context.mounted) {
                    context.setLocale(const Locale("ar"));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
