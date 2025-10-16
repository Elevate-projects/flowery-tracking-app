import 'package:flowery_tracking_app/api/client/request_mapper.dart';
import 'package:flowery_tracking_app/api/requests/reset_password/reset_password_request_model.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toDto with null values it should return null values', () {
    final ResetPasswordRequestEntity entity = const ResetPasswordRequestEntity(
      email: '',
      newPassword: '',
    );
    final ResetPasswordRequestModel model = RequestMapper.resetPasswordToModel(
      entity,
    );
    expect(model.email, '');
  });
  test(
    'when call toDto with non-null values it should return right values',
    () {
      final ResetPasswordRequestEntity entity =
          const ResetPasswordRequestEntity(
            email: 'moaazhassan559@gmail.com',
            newPassword: 'MyNewPassword123',
          );
      final ResetPasswordRequestModel model =
          RequestMapper.resetPasswordToModel(entity);
      expect(model.email, equals(entity.email));
      expect(model.newPassword, equals(entity.newPassword));
    },
  );
}
