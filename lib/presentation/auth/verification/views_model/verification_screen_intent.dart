import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';

sealed class VerificationScreenIntent {}

class InitializeVerificationFormIntent extends VerificationScreenIntent {}

class OnVerificationIntent extends VerificationScreenIntent {
  VerifyRequestEntity request;

  OnVerificationIntent({required this.request});
}

class OnResendCodeClickIntent extends VerificationScreenIntent {
  ForgetPasswordAndResendCodeRequestEntity request;

  OnResendCodeClickIntent({required this.request});
}

class OnStartTimer extends VerificationScreenIntent {}
