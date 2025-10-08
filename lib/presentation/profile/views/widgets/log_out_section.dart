import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/constants/widget_keys.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogOutSection extends StatelessWidget {
  const LogOutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final globalCubit = BlocProvider.of<GlobalCubit>(context);

    return RPadding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          Transform.rotate(
            angle: globalCubit.isArLanguage ? math.pi : 0,
            child: SvgPicture.asset(
              AppIcons.miniLogout,
              key: const ValueKey(WidgetKeys.logout),
            ),
          ),
          const RSizedBox(width: 5),
          Text(
            key: const ValueKey(WidgetKeys.logoutText),

            AppText.logout.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              //
            },
            child: Transform.rotate(
              angle: globalCubit.isArLanguage ? math.pi : 0,
              child: SvgPicture.asset(
                AppIcons.logout,
                key: const ValueKey(WidgetKeys.logout),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
