import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/reset_password/reset_password_response.dart';
import 'package:flowery_tracking_app/data/data_source/reset_password/reset_password_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/reset_password/reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordRepository)
class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  ResetPasswordDataSource resetPasswordDataSource;

  @factoryMethod
  ResetPasswordRepositoryImpl(this.resetPasswordDataSource);

  @override
  Future<Result<ResetPasswordResponse>> resetPassword(
    ResetPasswordRequestEntity request,
  ) {
    return resetPasswordDataSource.resetPassword(request);
  }
}
