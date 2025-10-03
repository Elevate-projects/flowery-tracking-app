import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/requests/adit_profile/edit_profile_request.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/edit_profile/edit_profile_repositories.dart';
import 'package:flowery_tracking_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([EditProfileRepositories])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'when calling editProfile, it should call EditProfileRepositories and return DriverDataEntity',
        () async {
      // Arrange
      final mockRepository = MockEditProfileRepositories();
      final useCase = EditProfileUseCase(mockRepository);

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

      final expectedResult = Success<DriverDataEntity>(driverDataEntity);
      provideDummy<Result<DriverDataEntity>>(expectedResult);

      when(mockRepository.editProfile(request))
          .thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase.editProfile(request);

      // Assert
      verify(mockRepository.editProfile(request)).called(1);
      expect(result, isA<Success<DriverDataEntity>>());
      expect((result as Success<DriverDataEntity>).data.firstName, equals("Ahmed"));
    },
  );
}
