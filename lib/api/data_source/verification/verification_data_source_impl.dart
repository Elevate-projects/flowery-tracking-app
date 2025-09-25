import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_maper.dart';
import 'package:flowery_tracking_app/api/responses/verification/verify_response.dart';
import 'package:flowery_tracking_app/data/data_source/verification/verification_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VerificationDataSource)
class VerificationDataSourceImpl implements VerificationDataSource {
  final ApiClient _apiClient;

  const VerificationDataSourceImpl(this._apiClient);

  @override
  Future<Result<VerifyResponse>> verify(VerifyRequestEntity request) async {
    return executeApi(() async {
      final res = await _apiClient.verificationCode(
        RequestMapper.verifyToModel(request),
      );
      return res;
    });
  }
}
