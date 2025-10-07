
import 'package:flowery_tracking_app/data/repositories/edit_profile/edit_profile_repository_impl.dart';
import 'package:flowery_tracking_app/domain/entities/edit_profile/edit_profile_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/data/data_source/edit_profile/edit_profile_remote_data_source.dart';

import 'edit_profile_repository_imp_test.mocks.dart';

@GenerateMocks([EditProfileRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'when calling editProfile, it should call EditProfileRemoteDataSource and return DriverDataEntity',
        () async {
      // Arrange
      final mockDataSource = MockEditProfileRemoteDataSource();
      final repository = EditProfileRepositoriesImpl(mockDataSource);

      final request = EditProfileRequestEntity(
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

      // Stub
      when(mockDataSource.editProfile(request))
          .thenAnswer((_) async => expectedResult);

      // Act
      final result = await repository.editProfile(request);

      // Assert
      verify(mockDataSource.editProfile(request)).called(1);
      expect(result, isA<Success<DriverDataEntity>>());
      expect((result as Success<DriverDataEntity>).data.firstName, "Ahmed");
    },
  );
}
