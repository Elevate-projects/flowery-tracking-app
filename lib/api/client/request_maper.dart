import 'package:flowery_tracking_app/api/requests/login_request/login_request_model.dart';
import 'package:flowery_tracking_app/domain/entities/requests/login_request/login_request_entity.dart';

import 'package:flowery_tracking_app/api/requests/forget_password_and_resend_code/forget_password_and_resend_code_request_model.dart';
import 'package:flowery_tracking_app/api/requests/reset_password/reset_password_request_model.dart';
import 'package:flowery_tracking_app/api/requests/verification/verify_request_model.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';

abstract class RequestMapper {
  static LoginRequestModel toLoginRequestModel({
    required LoginRequestEntity loginRequestEntity,
  }) {
    return LoginRequestModel(
      email: loginRequestEntity.email,
      password: loginRequestEntity.password,
    );
  }
  static ForgetPasswordAndResendCodeRequestModel
  toForgetPasswordAndResendCodeRequestModel({
    required ForgetPasswordAndResendCodeRequestEntity
    forgetPasswordRequestEntity,
  }) {
    return ForgetPasswordAndResendCodeRequestModel(
      email: forgetPasswordRequestEntity.email,
    );
  }

  static VerifyRequestModel verifyToModel(VerifyRequestEntity entity) {
    return VerifyRequestModel(resetCode: entity.resetCode);
  }

  static ResetPasswordRequestModel resetPasswordToModel(
    ResetPasswordRequestEntity entity,
  ) {
    return ResetPasswordRequestModel(
      email: entity.email,
      newPassword: entity.newPassword,
    );
  }
}
