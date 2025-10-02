import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/presentation/profile/views/widgets/language_section.dart';
import 'package:flowery_tracking_app/presentation/profile/views/widgets/log_out_section.dart';
import 'package:flowery_tracking_app/presentation/profile/views/widgets/user_card.dart';
import 'package:flowery_tracking_app/presentation/profile/views/widgets/vehicle_card.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) => current.profileStatus.isFailure||
          current.logoutStatus.isSuccess,

      listener: (BuildContext context, state) {
        if (state.profileStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.profileStatus.error?.message ?? "",
            context: context,
          );
        }else if(state.logoutStatus.isSuccess){
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(RouteNames.login, (route) => false);
        }
      },
      child: RPadding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const UserCard(),
            const RSizedBox(height: 25),
            const VehicleCard(),
            const RSizedBox(height: 30),

            const LanguageSection(),
            const RSizedBox(height: 15),

            const LogOutSection(),
            const Spacer(),
            RPadding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(
                AppText.appVersion.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.shadow,
                ),
              ),
            ),
            const RSizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
