import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/profile_reset_password/profile_reset_password_response.dart';
import 'package:flowery_tracking_app/domain/entities/requests/profile_reset_password/profile_reset_password_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/profile_reset_password/profile_reset_password_repository.dart';
import 'package:flowery_tracking_app/domain/use_cases/profile_reset_password/profile_reset_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_reset_password_usecase_test.mocks.dart';

@GenerateMocks([ProfileResetPasswordRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  resendCode from dataSource ', () async {
    final mockRepo = MockProfileResetPasswordRepository();
    final GetProfileResetPasswordUseCase useCase =
        GetProfileResetPasswordUseCase(mockRepo);
    final request = const ProfileResetPasswordRequestEntity(
      password: 'Moaaz@123',
      newPassword: 'Moaaz@1234',
    );

    final expectedResponse = ProfileResetPasswordResponse(
      token: 'sample_token',
      message: 'Password Changed successfully',
    );
    final expectedResult = Success(expectedResponse);
    provideDummy<Result<ProfileResetPasswordResponse>>(expectedResult);

    when(
      mockRepo.profileResetPassword(request),
    ).thenAnswer((_) async => expectedResult);

    final result = await useCase.execute(request);

    verify(mockRepo.profileResetPassword(request)).called(1);

    expect(result, isA<Success<ProfileResetPasswordResponse>>());

    result as Success<ProfileResetPasswordResponse>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
