import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/verification/verify_response.dart';
import 'package:flowery_tracking_app/data/data_source/verification/verification_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/verification/verification_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VerificationRepository)
class VerificationRepositoryImpl implements VerificationRepository {
  final VerificationDataSource _verificationDataSource;

  const VerificationRepositoryImpl(this._verificationDataSource);

  @override
  Future<Result<VerifyResponse>> verify(VerifyRequestEntity request) {
    return _verificationDataSource.verify(request);
  }
}
