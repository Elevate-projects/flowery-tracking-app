import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/constants/widget_keys.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final globalCubit = BlocProvider.of<GlobalCubit>(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (prev, curr) =>
          prev.profileStatus.data != curr.profileStatus.data,
      builder: (BuildContext context, state) {
        return Container(
          key: const ValueKey(WidgetKeys.vehicleCard),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,

            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withAlpha((0.1 * 255).round()),
                blurRadius: 10.r,
              ),
            ],
          ),

          child: RPadding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      key: const ValueKey(WidgetKeys.vehicleInfo),
                      AppText.vehicleInfo.tr(),
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.start,
                    ),
                    const RSizedBox(height: 4),
                    Text(
                      key: const ValueKey(WidgetKeys.vehicleType),

                      FloweryDriverMethodHelper.driverData?.vehicleType ?? "",
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.black
                      ),
                    ),
                    const RSizedBox(height: 2),
                    Text(
                      key: const ValueKey(WidgetKeys.vehicleNumber),

                      FloweryDriverMethodHelper.driverData?.vehicleNumber ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge?.copyWith(
                          color: AppColors.black
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                     // Navigator.pushNamed(context, RouteNames.editVehicle) ;
                  },
                  child: Transform.rotate(
                      angle:  globalCubit.isArLanguage ? math.pi : 0,
                      child: SvgPicture.asset(
                        key: const ValueKey(WidgetKeys.arrowRight),
                    AppIcons.arrowRight,))
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
