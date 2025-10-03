// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flowery_tracking_app/api/client/api_result.dart';
// import 'package:flowery_tracking_app/api/requests/edit_vechicle/edit_vehicle_request.dart';
// import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
// import 'package:flowery_tracking_app/data/repositories/edit_vehicle/edit_vehicle_repositories_imp.dart';
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   test(
//     'editVehicle calls EditVehicleDataSource and returns DriverDataEntity',
//         () async {
//       // Arrange
//       final mockDataSource = MockEditVehicleDataSource();
//       final repository = EditVehicleRepositoriesImp(mockDataSource);
//
//       final request = EditVehicleRequest(
//         vehicleType: "Sedan",
//         vehicleNumber: "12345",
//         vehicleLicense: "ABC-987",
//       );
//
//       final driverDataEntity = DriverDataEntity(
//         firstName: "Ahmed",
//         lastName: "Ali",
//         email: "ahmed@gmail.com",
//         phone: "01000000000",
//         photo: "https://flower.elevateegy.com/uploads/default-profile.png",
//       );
//
//       final expectedResult = Success<DriverDataEntity>(driverDataEntity);
//
//       // Provide dummy value for Mockito
//       provideDummy<Result<DriverDataEntity>>(expectedResult);
//
//       // Stub
//       when(mockDataSource.editVehicle(request))
//           .thenAnswer((_) async => expectedResult);
//
//       // Act
//       final result = await repository.editVehicle(request);
//
//       // Assert
//       verify(mockDataSource.editVehicle(request)).called(1);
//       expect(result, isA<Success<DriverDataEntity>>());
//       expect((result as Success<DriverDataEntity>).data.firstName, "Ahmed");
//     },
//   );
// }
