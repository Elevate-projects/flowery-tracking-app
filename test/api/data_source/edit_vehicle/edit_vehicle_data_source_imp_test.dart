import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/data_source/edit_vehicle/edit_vehicle_data_source_imp.dart';
import 'package:flowery_tracking_app/api/models/driver_data/driver_data_model.dart';
import 'package:flowery_tracking_app/api/requests/edit_vechicle/edit_vehicle_request.dart';
import 'package:flowery_tracking_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'edit_vehicle_data_source_imp_test.mocks.dart';
@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockApiClient mockApiClient;
  late MockConnectivity mockConnectivity;
  late EditVehicleDataSourceImp dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    mockConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockConnectivity;
    dataSource = EditVehicleDataSourceImp(mockApiClient);

    // dummy token
    FloweryDriverMethodHelper.currentUserToken = "dummy_token";
  });

  test(
    'editVehicle calls apiClient with correct request and returns DriverDataEntity',
        () async {
      // Arrange
      final request = EditVehicleRequest(
        vehicleType: "Sedan",
        vehicleNumber: "12345",
        vehicleLicense: "ABC-987",
      );
      final diverModel = DriverDataModel(
        firstName: "Ahmed",
        lastName: "Ali",
        email: "ahmed@gmail.com",
        phone: "01000000000",
        photo: "https://flower.elevateegy.com/uploads/default-profile.png",
      );

      // Mock connectivity (optional)
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);

      // Mock apiClient
      when(mockApiClient.editVehicle(
        token: anyNamed('token'),
        request: anyNamed('request'),
      )).thenAnswer((_) async => diverModel);

      // Act
      final result = await dataSource.editVehicle(request);

      // Assert
      expect(result, isA<Success<DriverDataEntity>>());
      verify(mockApiClient.editVehicle(
        token: anyNamed('token'),
        request: anyNamed('request'),
      )).called(1);
        },
  );
}
