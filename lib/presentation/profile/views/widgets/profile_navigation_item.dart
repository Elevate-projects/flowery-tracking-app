import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileNavigationItem extends StatelessWidget {
  const ProfileNavigationItem({
    super.key,
    this.prefixIconPath,
    this.isIconWithTitle = true,
    this.title,
    this.titleWidget,
    this.onTap,
    this.isSuffixArrow = true,
    this.suffixWidget,
  });
  final String? prefixIconPath;
  final bool isIconWithTitle;
  final String? title;
  final Widget? titleWidget;
  final void Function()? onTap;
  final bool isSuffixArrow;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final globalCubit = BlocProvider.of<GlobalCubit>(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      highlightColor: theme.colorScheme.onPrimary,
      splashColor: theme.colorScheme.onPrimary,
      child: RPadding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
        child: Row(
          children: [
            Visibility(
              visible: isIconWithTitle,
              child: Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(prefixIconPath ?? ""),
                    const RSizedBox(width: 4),
                    Flexible(
                      child: Text(
                        title?.tr() ?? "",
                        style: theme.textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !isIconWithTitle,
              child: Expanded(child: titleWidget ?? const SizedBox()),
            ),
            Visibility(
              visible: isSuffixArrow,
              child: Transform.rotate(
                angle: globalCubit.isArLanguage ? math.pi : 0,
                child: SvgPicture.asset(
                  AppIcons.arrowRight,
                  width: 24.r,
                  height: 24.r,
                ),
              ),
            ),
            Visibility(
              visible: !isSuffixArrow,
              child: suffixWidget ?? const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}