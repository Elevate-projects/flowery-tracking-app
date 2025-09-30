import 'package:flowery_tracking_app/domain/entities/requests/profile_reset_password/profile_reset_password_entity.dart';

sealed class ProfileResetPasswordIntent {}

class InitializeProfileResetPasswordFormIntent
    extends ProfileResetPasswordIntent {}

class OnProfileResetPasswordIntent extends ProfileResetPasswordIntent {
  final ProfileResetPasswordRequestEntity request;


  OnProfileResetPasswordIntent({required this.request});
}
