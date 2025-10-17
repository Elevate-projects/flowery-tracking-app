import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/data_source/vehicle/remote_data_source/vehicle_remote_data_source_impl.dart';
import 'package:flowery_tracking_app/api/models/vehicle/vehicle_model.dart';
import 'package:flowery_tracking_app/api/responses/vehicles_response/vehicles_response.dart';
import 'package:flowery_tracking_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'vehicle_remote_data_source_impl_test.mocks.dart';
@GenerateMocks([ApiClient,Connectivity])
void main() {
  test("when call getAllVehicles from apiClient", () async {
       final mockApiClient = MockApiClient();
       final mockConnectivity = MockConnectivity();
        ConnectionManager.connectivity = mockConnectivity;
        final dataSource = VehicleRemoteDataSourceImpl(mockApiClient);
        final VehicleModel vehicleModel =  VehicleModel(id: '1', type: 'sedan');
        final vehiclesResponse =VehiclesResponse(message: "success", vehicles: [VehicleModel(id: '1', type: 'sedan')]);
        final vehicleEntity = vehicleModel.toVehicleEntity();
        final expectedVehicleResponse = Success([vehicleEntity]);
        provideDummy<Result<List<VehicleEntity>>>(expectedVehicleResponse);
        when(
      mockConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);
    when(mockApiClient.getAllVehicles()).thenAnswer((_)async=> vehiclesResponse);
    // Act
    final result = await dataSource.fetchAllVehicles();
    final successResult = result as Success<List<VehicleEntity>>;
    // Assert
    expect(result, isA<Success<List<VehicleEntity>>>());
    verify(mockApiClient.getAllVehicles()).called(1);
    expect(expectedVehicleResponse.data, successResult.data);
  });
}