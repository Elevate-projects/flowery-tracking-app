import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/presentation/profile/views/widgets/language_section.dart';
import 'package:flowery_tracking_app/presentation/profile/views/widgets/logout_section.dart';
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
      listenWhen: (previous, current) =>
          current.profileStatus.isFailure ||
          current.logoutStatus.isFailure ||
          current.logoutStatus.isSuccess,
      listener: (context, state) {
        if (state.profileStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.profileStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.logoutStatus.isFailure) {
          Navigator.of(context).pop();
          Loaders.showErrorMessage(
            message: state.logoutStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.logoutStatus.isSuccess) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(RouteNames.onboarding, (route) => false);
        }
      },
      child: SingleChildScrollView(
        child: RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const RSizedBox(height: 31),
              const UserCard(),
              const RSizedBox(height: 24),
              const VehicleCard(),
              const RSizedBox(height: 24),
              const LanguageSection(),
              const RSizedBox(height: 8),
              const LogoutSection(),
              const RSizedBox(height: 235),
              RPadding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  AppText.appVersion.tr(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.shadow,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
