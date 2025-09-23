import 'package:flowery_tracking_app/api/client/request_maper.dart';
import 'package:flowery_tracking_app/api/requests/verification/verify_request_model.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toModel with null values it should return null values', () {
    final VerifyRequestEntity entity = VerifyRequestEntity(resetCode: null);
    final VerifyRequestModel model = RequestMapper.verifyToModel(entity);
    expect(model.resetCode, isNull);
  });
  test(
    'when call toModel with non-null values it should return right values',
    () {
      final VerifyRequestEntity entity = VerifyRequestEntity(
        resetCode: '123456',
      );
      final VerifyRequestModel model = RequestMapper.verifyToModel(entity);
      expect(model.resetCode, equals(entity.resetCode));
    },
  );
}
