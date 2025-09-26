import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/forget_password_and_resend_code/forget_password_and_resend_code_response.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';

abstract interface class ForgetPasswordAndResendCodeRepository {
  Future<Result<ForgetPasswordAndResendCodeResponse>> resendCode(
    ForgetPasswordAndResendCodeRequestEntity request,
  );
}
