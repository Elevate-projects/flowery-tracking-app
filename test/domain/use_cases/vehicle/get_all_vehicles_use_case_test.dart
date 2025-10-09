import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/models/vehicle/vehicle_model.dart';
import 'package:flowery_tracking_app/api/responses/vehicles_response/vehicles_response.dart';
import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/vehicle/vehicle_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_vehicles_use_case_test.mocks.dart';
@GenerateMocks([VehicleRepository])
void main(){
test('when call fetchAllVehicle from VehicleRepository ', ()async{
  // Arrange
  final mockVehicleRepository = MockVehicleRepository();
    final VehicleModel vehicleModel =  VehicleModel(id: '1', type: 'sedan');
        final vehiclesResponse =VehiclesResponse(message: "success", vehicles: [VehicleModel(id: '1', type: 'sedan')]);
        final vehicleEntity = vehicleModel.toVehicleEntity();
        final expectedVehicleResponse = Success([vehicleEntity]);
        provideDummy<Result<List<VehicleEntity>>>(expectedVehicleResponse);
  when(mockVehicleRepository.fetchAllVehicles()).thenAnswer((_) async => expectedVehicleResponse);
  // Act
    final result = await mockVehicleRepository.fetchAllVehicles();
    final successResult = result as Success<List<VehicleEntity>>;
    // Assert
    expect(result, isA<Success<List<VehicleEntity>>>());
    verify(mockVehicleRepository.fetchAllVehicles()).called(1);
    expect(expectedVehicleResponse.data, successResult.data);
});
}