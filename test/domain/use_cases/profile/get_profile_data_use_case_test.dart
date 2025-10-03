import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/domain/use_cases/profile/get_profile_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/profile/profile_repository.dart';
 import 'package:flowery_tracking_app/api/client/api_result.dart';

import 'get_profile_data_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late GetProfileDataUseCase useCase;
  late MockProfileRepository mockRepository;

  setUp(() {
    mockRepository = MockProfileRepository();
    useCase = GetProfileDataUseCase(mockRepository);
    provideDummy<DriverDataEntity?>(DriverDataEntity(firstName: "dummy"));
    provideDummy<Result<DriverDataEntity?>>(Success(DriverDataEntity(firstName: "dummy")));
  });

  test("call returns Success when repository fetchUserData succeeds", () async {
    // Arrange
    final fakeDriver = DriverDataEntity(
      id: "123",
      firstName: "Peter",
      lastName: "Rafek",
      email: "peter@gmail.com",
    );

    when(mockRepository.fetchUserData())
        .thenAnswer((_) async => Success(fakeDriver));

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, isA<Success<DriverDataEntity?>>());
    final success = result as Success<DriverDataEntity?>;
    expect(success.data?.firstName, equals("Peter"));
    expect(success.data?.email, equals("peter@gmail.com"));
    verify(mockRepository.fetchUserData()).called(1);
  });

  test("call returns Failure when repository fetchUserData fails", () async {
    // Arrange
    final failure = Failure<DriverDataEntity?>(
      responseException: const ResponseException(message: "Failed to fetch data"),
    );
    when(mockRepository.fetchUserData())
        .thenAnswer((_) async => failure);

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, isA<Failure<DriverDataEntity?>>());
    final fail = result as Failure<DriverDataEntity?>;
    expect(fail.responseException.message, equals("Failed to fetch data"));
    verify(mockRepository.fetchUserData()).called(1);
  });
}
