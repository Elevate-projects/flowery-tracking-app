
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_maper.dart';
import 'package:flowery_tracking_app/api/responses/profile_reset_password/profile_reset_password_response.dart';
import 'package:flowery_tracking_app/data/data_source/profile_reset_password/profile_reset_password_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/requests/profile_reset_password/profile_reset_password_entity.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileResetPasswordDataSource)
class ProfileResetPasswordDataSourceImpl
    implements ProfileResetPasswordDataSource {
  final ApiClient _apiClient;

  const ProfileResetPasswordDataSourceImpl(this._apiClient);

  @override
  Future<Result<ProfileResetPasswordResponse>> profileResetPassword({
    required ProfileResetPasswordRequestEntity request,
  }) async {
    return executeApi(() async {
      final res = await _apiClient.profileResetPassword(
        token: "Bearer ${FloweryDriverMethodHelper.currentUserToken}",
        entity: RequestMapper.toProfileResetPasswordRequest(entity: request),
      );
      FloweryDriverMethodHelper.currentUserToken = res.token;
      return res;
    });
  }
}
