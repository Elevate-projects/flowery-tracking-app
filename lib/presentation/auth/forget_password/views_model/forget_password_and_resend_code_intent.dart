import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';

sealed class ForgetPasswordAndResendCodeIntent {
  const ForgetPasswordAndResendCodeIntent();
}

class InitializeForgetPasswordFormIntent
    extends ForgetPasswordAndResendCodeIntent {
  const InitializeForgetPasswordFormIntent();
}

class OnConfirmEmailClickIntent extends ForgetPasswordAndResendCodeIntent {
  final ForgetPasswordAndResendCodeRequestEntity request;

  const OnConfirmEmailClickIntent({required this.request});
}
