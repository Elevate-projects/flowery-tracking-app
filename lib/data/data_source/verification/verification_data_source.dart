import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/verification/verify_response.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';

abstract interface class VerificationDataSource {
  Future<Result<VerifyResponse>> verify(VerifyRequestEntity request);
}
