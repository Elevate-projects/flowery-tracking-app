import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_maper.dart';
import 'package:flowery_tracking_app/api/data_source/reset_password/reset_password_data_source_impl.dart';
import 'package:flowery_tracking_app/api/responses/reset_password/reset_password_response.dart';
import 'package:flowery_tracking_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../forget_password_and_resend_code/forget_password_and_resend_code_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling resetCodeEndpoint from API', () async {
    final mockApiClient = MockApiClient();
    final mockConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockConnectivity;
    final ResetPasswordDataSourceImpl dataSource = ResetPasswordDataSourceImpl(
      mockApiClient,
    );

    final resetCodeRequest = const ResetPasswordRequestEntity(
      email: 'moaazhassan559@gmail.com',
      newPassword: '12345678',
    );

    final expectedResponse = const ResetPasswordResponse(
      token: 'sample_token',
      message: 'Password reset successfully',
      code: 200,
    );

    when(
      mockConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);

    when(
      mockApiClient.resetPassword(
        RequestMapper.resetPasswordToModel(resetCodeRequest),
      ),
    ).thenAnswer((_) async => expectedResponse);

    final result = await dataSource.resetPassword(resetCodeRequest);

    verify(
      mockApiClient.resetPassword(
        RequestMapper.resetPasswordToModel(resetCodeRequest),
      ),
    ).called(1);

    expect(result, isA<Success<ResetPasswordResponse>>());

    result as Success<ResetPasswordResponse>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
