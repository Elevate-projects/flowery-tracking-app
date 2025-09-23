import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/forget_password_and_resend_code/forget_password_and_resend_code_response.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/forget_password_and_resend_code/forget_password_and_resend_code_repository.dart';
import 'package:flowery_tracking_app/domain/use_cases/forget_password_and_resend_code/forget_password_and_resend_code_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_and_resend_code_usecase_test.mocks.dart';

@GenerateMocks([ForgetPasswordAndResendCodeRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  resendCode from dataSource ', () async {
    final mockRepo = MockForgetPasswordAndResendCodeRepository();
    final GetForgetPasswordResendCodeUseCase useCase =
        GetForgetPasswordResendCodeUseCase(mockRepo);

    final resendCodeRequest = ForgetPasswordAndResendCodeRequestEntity(
      email: 'moaazhassan559@gmail.com',
    );
    final expectedResponse = const ForgetPasswordAndResendCodeResponse(
      info: 'Please check your email for the verification code.',
      message: 'Verification code sent successfully',
    );
    final expectedResult = Success(expectedResponse);
    provideDummy<Result<ForgetPasswordAndResendCodeResponse>>(expectedResult);

    when(
      mockRepo.resendCode(resendCodeRequest),
    ).thenAnswer((_) async => expectedResult);

    final result = await useCase.execute(resendCodeRequest);

    verify(mockRepo.resendCode(resendCodeRequest)).called(1);

    expect(result, isA<Success<ForgetPasswordAndResendCodeResponse>>());

    result as Success<ForgetPasswordAndResendCodeResponse>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
