import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_mapper.dart';
import 'package:flowery_tracking_app/api/data_source/verification/verification_data_source_impl.dart';
import 'package:flowery_tracking_app/api/responses/verification/verify_response.dart';
import 'package:flowery_tracking_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../forget_password_and_resend_code/forget_password_and_resend_code_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling verificationEndpoint from API', () async {
    final mockApiClient = MockApiClient();
    final mockConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockConnectivity;
    final VerificationDataSourceImpl dataSource = VerificationDataSourceImpl(
      mockApiClient,
    );

    final verifyRequest = VerifyRequestEntity(resetCode: '123456');

    final expectedResponse = const VerifyResponse(
      message: 'Verification successful',
      status: 'success',
      code: 200,
    );

    when(
      mockConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);

    when(
      mockApiClient.verificationCode(
        RequestMapper.verifyToModel(verifyRequest),
      ),
    ).thenAnswer((_) async => expectedResponse);

    final result = await dataSource.verify(verifyRequest);

    verify(
      mockApiClient.verificationCode(
        RequestMapper.verifyToModel(verifyRequest),
      ),
    ).called(1);

    expect(result, isA<Success<VerifyResponse>>());

    result as Success<VerifyResponse>;

    expect(result.data.message, expectedResponse.message);
  });
}
