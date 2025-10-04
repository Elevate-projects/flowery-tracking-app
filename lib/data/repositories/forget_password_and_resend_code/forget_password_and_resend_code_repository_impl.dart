import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/forget_password_and_resend_code/forget_password_and_resend_code_response.dart';
import 'package:flowery_tracking_app/data/data_source/forget_password_and_resend_code/forget_password_and_resend_code_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/forget_password_and_resend_code/forget_password_and_resend_code_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordAndResendCodeRepository)
class ForgetPasswordAndResendCodeRepositoryImpl
    implements ForgetPasswordAndResendCodeRepository {
  final ForgetPasswordAndResendCodeDataSource
  _forgetPasswordAndResendCodeDataSource;

  ForgetPasswordAndResendCodeRepositoryImpl(
    this._forgetPasswordAndResendCodeDataSource,
  );

  @override
  Future<Result<ForgetPasswordAndResendCodeResponse>> resendCode(
    ForgetPasswordAndResendCodeRequestEntity request,
  ) {
    return _forgetPasswordAndResendCodeDataSource.resendCode(request);
  }
}
