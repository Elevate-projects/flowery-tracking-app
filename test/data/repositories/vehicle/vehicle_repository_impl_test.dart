import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/models/vehicle/vehicle_model.dart';
import 'package:flowery_tracking_app/data/data_source/vehicle/remote_data_source/vehicle_remote_data_source.dart';
import 'package:flowery_tracking_app/data/repositories/vehicle/vehicle_repository_impl.dart';
import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'vehicle_repository_impl_test.mocks.dart';
@GenerateMocks([VehicleRemoteDataSource])
void main(){
  test('when call fetchAllVehicles', ()async{
    // Arrange
    final mockRemoteDataSource = MockVehicleRemoteDataSource();
    final repository = VehicleRepositoryImpl(mockRemoteDataSource);
     final VehicleModel vehicleModel =  VehicleModel(id: '1', type: 'sedan');
        final vehicleEntity = vehicleModel.toVehicleEntity();
        final expectedVehicleResponse = Success([vehicleEntity]);
        provideDummy<Result<List<VehicleEntity>>>(expectedVehicleResponse);
    when(mockRemoteDataSource.fetchAllVehicles()).thenAnswer((_) async => expectedVehicleResponse);
    // Act
    final result = await repository.fetchAllVehicles();
    final successResult = result as Success<List<VehicleEntity>>;
    // Assert
    expect(result, isA<Success<List<VehicleEntity>>>());
    verify(mockRemoteDataSource.fetchAllVehicles()).called(1);
    expect(expectedVehicleResponse.data, successResult.data);
  });
}