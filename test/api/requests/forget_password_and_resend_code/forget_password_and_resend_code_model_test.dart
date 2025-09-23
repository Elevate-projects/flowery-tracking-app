import 'package:flowery_tracking_app/api/client/request_maper.dart';
import 'package:flowery_tracking_app/api/requests/forget_password_and_resend_code/forget_password_and_resend_code_request_model.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toModel with null values it should return null values', () {
    final ForgetPasswordAndResendCodeRequestEntity entity =
        ForgetPasswordAndResendCodeRequestEntity(email: null);
    final ForgetPasswordAndResendCodeRequestModel model =
        RequestMapper.toForgetPasswordAndResendCodeRequestModel(
          forgetPasswordRequestEntity: entity,
        );
    expect(model.email, isNull);
  });
  test(
    'when call toModel with non-null values it should return right values',
    () {
      final ForgetPasswordAndResendCodeRequestEntity entity =
          ForgetPasswordAndResendCodeRequestEntity(
            email: 'moaazhassan559@gmail.com',
          );
      final ForgetPasswordAndResendCodeRequestModel model =
          RequestMapper.toForgetPasswordAndResendCodeRequestModel(
            forgetPasswordRequestEntity: entity,
          );
      expect(model.email, equals(entity.email));
    },
  );
}
