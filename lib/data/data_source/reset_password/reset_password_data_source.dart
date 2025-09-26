import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/reset_password/reset_password_response.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';

abstract interface class ResetPasswordDataSource {
  Future<Result<ResetPasswordResponse>> resetPassword(
    ResetPasswordRequestEntity request,
  );
}
