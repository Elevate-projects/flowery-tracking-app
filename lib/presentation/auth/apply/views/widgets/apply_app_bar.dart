import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ApplyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      centerTitle: false,
      isTitleWidget: true,
      automaticallyImplyLeading: false,
      titleWidget: RPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [const CustomBackArrow(), Text(AppText.apply.tr())],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
