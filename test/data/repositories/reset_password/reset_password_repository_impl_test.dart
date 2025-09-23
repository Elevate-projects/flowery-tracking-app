
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/reset_password/reset_password_response.dart';
import 'package:flowery_tracking_app/data/data_source/reset_password/reset_password_data_source.dart';
import 'package:flowery_tracking_app/data/repositories/reset_password/reset_password_repository_impl.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_repository_impl_test.mocks.dart';

@GenerateMocks([ResetPasswordDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  resetCode from dataSource ', () async {
    final mockDataSource = MockResetPasswordDataSource();
    final ResetPasswordRepositoryImpl repo = ResetPasswordRepositoryImpl(
      mockDataSource,
    );

    final resetCodeRequest = ResetPasswordRequestEntity(
      email: 'moaazhassan559@gmail.com',
      newPassword: '12345678',
    );
    final expectedResponse = const ResetPasswordResponse(
      token: 'sample_token',
      message: 'Password reset successfully',
      code: 200,
    );
    final expectedResult = Success(expectedResponse);
    provideDummy<Result<ResetPasswordResponse>>(expectedResult);

    when(
      mockDataSource.resetPassword(resetCodeRequest),
    ).thenAnswer((_) async => expectedResult);

    final result = await repo.resetPassword(resetCodeRequest);

    verify(mockDataSource.resetPassword(resetCodeRequest)).called(1);

    expect(result, isA<Success<ResetPasswordResponse>>());

    result as Success<ResetPasswordResponse>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}