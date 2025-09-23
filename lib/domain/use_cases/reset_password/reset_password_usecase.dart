import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/reset_password/reset_password_response.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/reset_password/reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetResetPasswordUseCase {
  ResetPasswordRepository resetPasswordRepository;

  @factoryMethod
  GetResetPasswordUseCase(this.resetPasswordRepository);

  Future<Result<ResetPasswordResponse>> execute(
    ResetPasswordRequestEntity request,
  ) {
    return resetPasswordRepository.resetPassword(request);
  }
}
