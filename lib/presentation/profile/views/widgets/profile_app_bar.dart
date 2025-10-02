import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (BuildContext context, state) {
        return CustomAppBar(
          key: const ValueKey(ConstKeys.profileAppBar),
          isTitleWidget: true,
          titleWidget: RPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const CustomBackArrow(key: ValueKey(ConstKeys.customBackArrow)),
                Text(AppText.profile.tr()),
                const Spacer(),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, RouteNames.notificationList);
                      },
                      child: SvgPicture.asset(
                        key: const ValueKey(ConstKeys.notification),
                        AppIcons.notification,
                        width: 24.r,
                        height: 24.r,
                      ),
                    ),
                    PositionedDirectional(
                      end: -2,
                      top: -4,
                      child: Container(
                        width: 16.r,
                        height: 16.r,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error,
                          shape: BoxShape.circle,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "3",
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.secondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
