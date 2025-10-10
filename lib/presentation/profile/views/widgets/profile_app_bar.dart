import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/constants/widget_keys.dart';
import 'package:flowery_tracking_app/presentation/profile/views/widgets/positioned_directional_widget.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_app_bar.dart';
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
          key: const ValueKey(WidgetKeys.profileAppBar),
          isTitleWidget: true,
          titleWidget: RPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: FittedBox(
                    alignment: AlignmentDirectional.centerStart,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      AppText.profile.tr(),
                      style: theme.textTheme.headlineMedium,
                    ),
                  ),
                ),

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, RouteNames.notificationList);
                      },
                      child: SvgPicture.asset(
                        key: const ValueKey(WidgetKeys.notification),
                        AppIcons.notification,
                        width: 24.r,
                        height: 24.r,
                      ),
                    ),
                    const PositionedDirectionalWidget(),
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
