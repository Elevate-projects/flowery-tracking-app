import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/forget_password_and_resend_code/forget_password_and_resend_code_response.dart';
import 'package:flowery_tracking_app/data/data_source/forget_password_and_resend_code/forget_password_and_resend_code_data_source.dart';
import 'package:flowery_tracking_app/data/repositories/forget_password_and_resend_code/forget_password_and_resend_code_repository_impl.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_and_resend_code_repository_impl_test.mocks.dart';

@GenerateMocks([ForgetPasswordAndResendCodeDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  resendCode from dataSource ', () async {
    final mockDataSource = MockForgetPasswordAndResendCodeDataSource();
    final ForgetPasswordAndResendCodeRepositoryImpl repo =
        ForgetPasswordAndResendCodeRepositoryImpl(mockDataSource);

    final request = const ForgetPasswordAndResendCodeRequestEntity(
      email: 'moaazhassan559@gmail.com',
    );
    final expectedResponse = const ForgetPasswordAndResendCodeResponse(
      info: 'Please check your email for the verification code.',
      message: 'Verification code sent successfully',
    );
    final expectedResult = Success(expectedResponse);
    provideDummy<Result<ForgetPasswordAndResendCodeResponse>>(expectedResult);

    when(
      mockDataSource.resendCode(request),
    ).thenAnswer((_) async => expectedResult);

    final result = await repo.resendCode(request);

    verify(mockDataSource.resendCode(request)).called(1);

    expect(result, isA<Success<ForgetPasswordAndResendCodeResponse>>());

    result as Success<ForgetPasswordAndResendCodeResponse>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
