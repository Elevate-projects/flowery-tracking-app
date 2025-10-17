import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/core/constants/widget_keys.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/presentation/profile/views/widgets/shimmer/profile_item_shimmer.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final globalCubit = BlocProvider.of<GlobalCubit>(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current.profileStatus.isLoading || current.profileStatus.isSuccess,
      builder: (BuildContext context, state) {
        return state.profileStatus.isLoading
            ? const ProfileItemShimmer()
            : Container(
                key: const ValueKey(WidgetKeys.userCard),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,

                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withAlpha((0.1 * 255).round()),
                      blurRadius: 10,
                    ),
                  ],
                ),

                child: RPadding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        key: const ValueKey(WidgetKeys.photo),
                        radius: 26,
                        backgroundColor: theme.colorScheme.onPrimary,
                        backgroundImage: CachedNetworkImageProvider(
                          FloweryDriverMethodHelper.driverData?.photo ?? "",
                        ),
                        onBackgroundImageError: (exception, stackTrace) =>
                            const Icon(Icons.info),
                      ),

                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                key: const ValueKey(WidgetKeys.name),
                                "${FloweryDriverMethodHelper.driverData?.firstName} ${FloweryDriverMethodHelper.driverData?.lastName}",
                                style: theme.textTheme.headlineSmall,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            const SizedBox(height: 4),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                key: const ValueKey(ConstKeys.email),

                                FloweryDriverMethodHelper.driverData?.email ??
                                    "",
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                key: const ValueKey(WidgetKeys.phone),

                                FloweryDriverMethodHelper.driverData?.phone ??
                                    "",
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: () {
                           Navigator.pushNamed(context, RouteNames.editProfile) ;
                        },
                        child: Transform.rotate(
                          angle: globalCubit.isArLanguage ? math.pi : 0,
                          child: SvgPicture.asset(
                            key: const ValueKey(WidgetKeys.arrowRight),
                            AppIcons.arrowRight,
                          ),
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
