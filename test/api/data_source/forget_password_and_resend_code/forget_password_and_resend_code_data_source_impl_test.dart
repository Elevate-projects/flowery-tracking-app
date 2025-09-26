import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_maper.dart';
import 'package:flowery_tracking_app/api/data_source/forget_password_and_resend_code/forget_password_and_resend_code_data_source_impl.dart';
import 'package:flowery_tracking_app/api/responses/forget_password_and_resend_code/forget_password_and_resend_code_response.dart';
import 'package:flowery_tracking_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_and_resend_code_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling resendCodeEndpoint from API', () async {
    final mockApiClient = MockApiClient();
    final mockConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockConnectivity;
    final ForgetPasswordAndResendCodeDataSourceImpl dataSource =
        ForgetPasswordAndResendCodeDataSourceImpl(mockApiClient);

    final forgetPasswordAndResendCodeRequest =
        const ForgetPasswordAndResendCodeRequestEntity(
          email: 'moaazhassan559@gmail.com',
        );

    final expectedResponse = const ForgetPasswordAndResendCodeResponse(
      message: 'Verification code sent successfully',
      info: 'Please check your email for the verification code.',
    );

    when(
      mockConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);

    when(
      mockApiClient.forgetPasswordAndResendCode(
        RequestMapper.toForgetPasswordAndResendCodeRequestModel(
          forgetPasswordRequestEntity: forgetPasswordAndResendCodeRequest,
        ),
      ),
    ).thenAnswer((_) async => expectedResponse);

    final result = await dataSource.resendCode(
      forgetPasswordAndResendCodeRequest,
    );

    verify(
      mockApiClient.forgetPasswordAndResendCode(
        RequestMapper.toForgetPasswordAndResendCodeRequestModel(
          forgetPasswordRequestEntity: forgetPasswordAndResendCodeRequest,
        ),
      ),
    ).called(1);

    expect(result, isA<Success<ForgetPasswordAndResendCodeResponse>>());

    result as Success<ForgetPasswordAndResendCodeResponse>;

    expect(result.data.message, expectedResponse.message);
  });
}
