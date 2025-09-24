import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views/widgets/bottom_navigation_item.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final ThemeData theme;

  const BottomNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: const ValueKey('bottom_nav_bar'),
      elevation: 1,
      backgroundColor: theme.colorScheme.secondary,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      items: [
        buildBottomNavItem(

          label: AppText.home.tr(),
          iconPath: AppIcons.home,

          index: 0,
          currentIndex: currentIndex,
          theme: theme,
        ),
        buildBottomNavItem(
          label: AppText.order.tr(),
          iconPath: AppIcons.factCheck,

          index: 1,
          currentIndex: currentIndex,
          theme: theme,
        ),
        buildBottomNavItem(
          label: AppText.profile.tr(),
          iconPath: AppIcons.profile,

          index: 2,
          currentIndex: currentIndex,
          theme: theme,
        ),
      ],
    );
  }
}
