import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';

sealed class ForgetPasswordAndResendCodeIntent {}

class InitializeForgetPasswordFormIntent
    extends ForgetPasswordAndResendCodeIntent {}

class OnConfirmEmailClickIntent extends ForgetPasswordAndResendCodeIntent {
  ForgetPasswordAndResendCodeRequestEntity request;

  OnConfirmEmailClickIntent({required this.request});
}
