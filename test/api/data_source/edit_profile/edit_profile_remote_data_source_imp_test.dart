import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/data_source/edit_profile/edit_profile_remote_data_source_imp.dart';
import 'package:flowery_tracking_app/api/models/driver_data/driver_data_model.dart';
import 'package:flowery_tracking_app/api/requests/adit_profile/edit_profile_request.dart';
import 'package:flowery_tracking_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_remote_data_source_imp_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'editProfile calls apiClient with correct request and returns DriverDataEntity',
        () async {
      // Arrange
      final mockApiClient = MockApiClient();
      final mockedConnectivity = MockConnectivity();
      ConnectionManager.connectivity = mockedConnectivity;
      final dataSource = EditProfileRemoteDataSourceImp(
        mockApiClient,
      );
      final request = EditProfileRequestModel(
        firstName: "Ahmed",
        lastName: "Ali",
        email: "ahmed@gmail.com",
        phone: "01000000000",
        password: "Ahmed\$123",
      );

      final driverDataEntity = DriverDataEntity(
        firstName: "Ahmed",
        lastName: "Ali",
        email: "ahmed@gmail.com",
        phone: "01000000000",
        photo: "https://flower.elevateegy.com/uploads/default-profile.png",
      );
      final driverDataModel = DriverDataModel(
        firstName: "Ahmed",
        lastName: "Ali",
        email: "ahmed@gmail.com",
        phone: "01000000000",
        photo: "https://flower.elevateegy.com/uploads/default-profile.png",
      );

      final expectedResult = Success(driverDataEntity);
      provideDummy<Result<DriverDataEntity>>(expectedResult);

      // Mock connectivity
      when(mockedConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(mockApiClient.editProfile(
        token: anyNamed("token"),
        request: anyNamed("request"),
      )).thenAnswer((_) async => driverDataModel);

      // Act
      final result = await dataSource.editProfile(request);

      // Assert
      expect(result, isA<Success<DriverDataEntity>>());

      // Verify apiClient was called with correct request
      verify(mockApiClient.editProfile(
        token: anyNamed("token"),
        request: request,
      )).called(1);
    },
  );
}
