import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/profile_reset_password/profile_reset_password_response.dart';
import 'package:flowery_tracking_app/domain/entities/requests/profile_reset_password/profile_reset_password_entity.dart';

abstract interface class ProfileResetPasswordDataSource {
  Future<Result<ProfileResetPasswordResponse>> profileResetPassword({
    required ProfileResetPasswordRequestEntity request,
  });
}
