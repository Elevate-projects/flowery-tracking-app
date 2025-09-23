import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/verification/verify_response.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/verification/verification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVerificationUseCase {
  VerificationRepository verificationRepository;

  @factoryMethod
  GetVerificationUseCase(this.verificationRepository);

  Future<Result<VerifyResponse>> execute(VerifyRequestEntity request) {
    return verificationRepository.verify(request);
  }
}
