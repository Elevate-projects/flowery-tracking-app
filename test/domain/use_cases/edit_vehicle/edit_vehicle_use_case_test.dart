import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/requests/edit_vechicle/edit_vehicle_request.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/edit_vehicle/edit_vehicle_repositories.dart';
import 'package:flowery_tracking_app/domain/use_cases/edit_vehicle/edit_vehicle_use_case.dart';

import 'edit_vehicle_use_case_test.mocks.dart';

@GenerateMocks([EditVehicleRepositories])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'when calling editVehicle, it should call EditVehicleRepositories and return DriverDataEntity',
        () async {
      // Arrange
      final mockRepository = MockEditVehicleRepositories();
      final useCase = EditVehicleUseCase(mockRepository);

      final request = EditVehicleRequest(
        vehicleType: "Sedan",
        vehicleNumber: "12345",
        vehicleLicense: "ABC-987",
      );

      final driverDataEntity = DriverDataEntity(
        firstName: "Ahmed",
        lastName: "Ali",
        email: "ahmed@gmail.com",
        phone: "01000000000",
        photo: "https://flower.elevateegy.com/uploads/default-profile.png",
      );

      final expectedResult = Success<DriverDataEntity>(driverDataEntity);

      // Provide dummy value for Mockito
      provideDummy<Result<DriverDataEntity>>(expectedResult);

      // Stub
      when(mockRepository.editVehicle(request))
          .thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase.editVehicle(request);

      // Assert
      verify(mockRepository.editVehicle(request)).called(1);
      expect(result, isA<Success<DriverDataEntity>>());
      expect((result as Success<DriverDataEntity>).data.firstName, equals("Ahmed"));
    },
  );
}
