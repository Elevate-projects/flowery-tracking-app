import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

BottomNavigationBarItem buildBottomNavItem({
  required String label,
  required String iconPath,
  required int index,
  required int currentIndex,
  required ThemeData theme,
}) {
  return BottomNavigationBarItem(
    label: label,
    icon: Padding(
      padding: EdgeInsets.only(top: 3.h, bottom: 4.h),
      child: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(
          currentIndex == index
              ? theme.colorScheme.primary
              : AppColors.white[80]!,
          BlendMode.srcIn,
        ),
      ),
    ),
  );
}
