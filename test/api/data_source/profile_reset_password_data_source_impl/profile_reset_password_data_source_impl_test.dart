import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_mapper.dart';
import 'package:flowery_tracking_app/api/data_source/profile_reset_password_data_source_impl/profile_reset_password_data_source_impl.dart';
import 'package:flowery_tracking_app/api/responses/profile_reset_password/profile_reset_password_response.dart';
import 'package:flowery_tracking_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_tracking_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_tracking_app/domain/entities/requests/profile_reset_password/profile_reset_password_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../presentation/auth/login/views_model/login_cubit_test.mocks.dart';
import '../forget_password_and_resend_code/forget_password_and_resend_code_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity, SecureStorage])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling changePassword from API', () async {
    final mockApiClient = MockApiClient();
    final mockSecureStorage = MockSecureStorage();
    final mockConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockConnectivity;
    final ProfileResetPasswordDataSourceImpl dataSource =
        ProfileResetPasswordDataSourceImpl(mockApiClient, mockSecureStorage);

    final request = const ProfileResetPasswordRequestEntity(
      password: 'Moaaz@123',
      newPassword: 'Moaaz@1234',
    );

    final expectedResponse = ProfileResetPasswordResponse(
      token: 'sample_token',
      message: 'Password Changed successfully',
    );

    when(
      mockConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);

    when(
      mockApiClient.profileResetPassword(
        request: RequestMapper.toProfileResetPasswordRequest(entity: request),
        token: anyNamed("token"),
      ),
    ).thenAnswer((_) async => expectedResponse);

    final result = await dataSource.profileResetPassword(request: request);

    verify(
      mockApiClient.profileResetPassword(
        request: RequestMapper.toProfileResetPasswordRequest(entity: request),
        token: anyNamed("token"),
      ),
    ).called(1);

    expect(result, isA<Success<ProfileResetPasswordResponse>>());

    result as Success<ProfileResetPasswordResponse>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
