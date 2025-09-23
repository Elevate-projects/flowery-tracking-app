import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/reset_password/reset_password_response.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/reset_password/reset_password_repository.dart';
import 'package:flowery_tracking_app/domain/use_cases/reset_password/reset_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_usecase_test.mocks.dart';

@GenerateMocks([ResetPasswordRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  resendCode from dataSource ', () async {
    final mockRepo = MockResetPasswordRepository();
    final GetResetPasswordUseCase useCase = GetResetPasswordUseCase(mockRepo);

    final resetCodeRequest = ResetPasswordRequestEntity(
      email: 'moaazhassan559@gmail.com',
      newPassword: 'newPassword123',
    );
    final expectedResponse = const ResetPasswordResponse(
      token: 'newlyGeneratedToken',
      code: 200,
      message: 'Password reset successfully',
    );
    final expectedResult = Success(expectedResponse);
    provideDummy<Result<ResetPasswordResponse>>(expectedResult);

    when(
      mockRepo.resetPassword(resetCodeRequest),
    ).thenAnswer((_) async => expectedResult);

    final result = await useCase.execute(resetCodeRequest);

    verify(mockRepo.resetPassword(resetCodeRequest)).called(1);

    expect(result, isA<Success<ResetPasswordResponse>>());

    result as Success<ResetPasswordResponse>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
