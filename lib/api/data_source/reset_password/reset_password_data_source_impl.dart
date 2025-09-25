import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_maper.dart';
import 'package:flowery_tracking_app/api/responses/reset_password/reset_password_response.dart';
import 'package:flowery_tracking_app/data/data_source/reset_password/reset_password_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordDataSource)
class ResetPasswordDataSourceImpl implements ResetPasswordDataSource {
  final ApiClient _apiClient;

  const ResetPasswordDataSourceImpl(this._apiClient);

  @override
  Future<Result<ResetPasswordResponse>> resetPassword(
    ResetPasswordRequestEntity request,
  ) async {
    return executeApi(() async {
      final res = await _apiClient.resetPassword(
        RequestMapper.resetPasswordToModel(request),
      );
      return res;
    });
  }
}
