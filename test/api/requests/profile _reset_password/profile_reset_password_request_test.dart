import 'package:flowery_tracking_app/api/client/request_mapper.dart';
import 'package:flowery_tracking_app/api/requests/profile%20_reset_password/profile_reset_password_request.dart';
import 'package:flowery_tracking_app/domain/entities/requests/profile_reset_password/profile_reset_password_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toDto with null values it should return null values', () {
    final ProfileResetPasswordRequestEntity entity =
        const ProfileResetPasswordRequestEntity(password: '', newPassword: '');
    final ProfileResetPasswordRequestModel model =
        RequestMapper.toProfileResetPasswordRequest(entity: entity);
    expect(model.password, '');
  });
  test(
    'when call toDto with non-null values it should return right values',
    () {
      final ProfileResetPasswordRequestEntity entity =
          const ProfileResetPasswordRequestEntity(
            password: 'OldPassword123',
            newPassword: 'MyNewPassword123',
          );
      final ProfileResetPasswordRequestModel model =
          RequestMapper.toProfileResetPasswordRequest(entity: entity);
      expect(model.password, equals(entity.password));
      expect(model.newPassword, equals(entity.newPassword));
    },
  );
}
