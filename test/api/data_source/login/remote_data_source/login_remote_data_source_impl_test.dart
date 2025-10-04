import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/data_source/login/remote_data_source/login_remote_data_source_impl.dart';
import 'package:flowery_tracking_app/api/responses/login_response/login_response.dart';
import 'package:flowery_tracking_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_tracking_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_tracking_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, SecureStorage, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call login it should be called successfully from apiClient',
    () async {
      // Arrange
      final mockApiClient = MockApiClient();
      final mockSecureStorage = MockSecureStorage();
      final mockedConnectivity = MockConnectivity();
      ConnectionManager.connectivity = mockedConnectivity;
      final loginRemoteDataSource = LoginRemoteDataSourceImpl(
        mockApiClient,
        mockSecureStorage,
      );
      final LoginRequestEntity requestEntity = LoginRequestEntity(
        email: "ahmed@gmail.com",
        password: "Ahmed\$123",
      );
      final expectedLoginResponse = LoginResponse(
        token: "currentUserToken",
        message: "success",
      );
      final expectedResult = Success(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(
        mockApiClient.login(request: anyNamed("request")),
      ).thenAnswer((_) async => expectedLoginResponse);

      // Act
      final result = await loginRemoteDataSource.login(request: requestEntity);

      // Assert
      expect(result, isA<Success<void>>());
      verify(mockApiClient.login(request: anyNamed("request"))).called(1);
    },
  );
}
