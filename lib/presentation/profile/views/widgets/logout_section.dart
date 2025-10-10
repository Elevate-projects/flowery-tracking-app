import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/presentation/profile/views/widgets/profile_navigation_item.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/loading_button.dart';
import 'package:flowery_tracking_app/utils/dialogs/dialogs.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LogoutSection extends StatelessWidget {
  const LogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileCubit = BlocProvider.of<ProfileCubit>(context);
    return ProfileNavigationItem(
      title: FloweryDriverMethodHelper.currentUserToken == null
          ? AppText.login
          : AppText.logout,
      prefixIconPath: AppIcons.logout,
      isSuffixArrow: false,
      suffixWidget: SvgPicture.asset(
        AppIcons.logout,
        width: 24.r,
        height: 24.r,
        colorFilter: ColorFilter.mode(
          theme.colorScheme.shadow,
          BlendMode.srcIn,
        ),
      ),
      onTap: FloweryDriverMethodHelper.currentUserToken == null
          ? () {
              Navigator.pushReplacementNamed(context, RouteNames.login);
            }
          : () async {
              await Dialogs.customDialog(
                isBarrierDismissible: false,
                context: context,
                content: BlocProvider.value(
                  value: profileCubit,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          AppText.logoutCapital.tr(),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const RSizedBox(height: 8),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          AppText.confirmLogout.tr(),
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: theme.colorScheme.onSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const RSizedBox(height: 24),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        buildWhen: (previous, current) =>
                            current.logoutStatus.isFailure ||
                            current.logoutStatus.isLoading,
                        builder: (context, state) => Row(
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                onPressed: state.logoutStatus.isLoading
                                    ? () {}
                                    : () {
                                        Navigator.of(context).pop();
                                      },
                                borderColor: theme.colorScheme.shadow,
                                backgroundColor: theme.colorScheme.secondary,
                                titleStyle: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.shadow,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.1,
                                ),
                                buttonTitle: AppText.cancel.tr(),
                                height: 40.h,
                              ),
                            ),
                            const RSizedBox(width: 16),
                            Expanded(
                              child: state.logoutStatus.isLoading
                                  ? LoadingButton(height: 40.h)
                                  : CustomElevatedButton(
                                      onPressed: () async {
                                        await profileCubit.doIntent(
                                          LogoutIntent(),
                                        );
                                      },
                                      buttonTitle: AppText.logout,
                                      titleStyle: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                            color: theme.colorScheme.secondary,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.1,
                                          ),
                                      height: 40.h,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
    );
  }
}
