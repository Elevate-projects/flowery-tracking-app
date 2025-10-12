import 'package:flowery_tracking_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';

sealed class ProfileIntent {}

class ProfileInitializationIntent extends ProfileIntent {
  ProfileInitializationIntent({required this.globalCubit});
  final GlobalCubit globalCubit;
}

class ToggleLanguageIntent extends ProfileIntent {
  ToggleLanguageIntent({
    required this.globalCubit,
    required this.newSelectedLanguage,
  });
  final GlobalCubit globalCubit;
  final Languages newSelectedLanguage;
}

class GetUserProfileDataIntent extends ProfileIntent {}

class LogoutIntent extends ProfileIntent {}
