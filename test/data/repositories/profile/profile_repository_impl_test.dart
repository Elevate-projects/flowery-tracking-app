import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/models/driver_data/driver_data_model.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/data/data_source/profile/remote_data_source/profile_remote_data_source.dart';
import 'package:flowery_tracking_app/data/repositories/profile/profile_repository_impl.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repository_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProfileRepositoryImpl repository;
  late MockProfileRemoteDataSource mockRemoteDataSource;
  setUp(() {
    provideDummy<Result<DriverDataEntity?>>(Success(null));

    mockRemoteDataSource = MockProfileRemoteDataSource();
    repository = ProfileRepositoryImpl(mockRemoteDataSource);
  });

  test(
    "fetchUserData returns Success when remote data source succeeds",
    () async {
      final fakeDriver = DriverDataModel(
        id: "123",
        firstName: "Peter",
        lastName: "Rafek",
        email: "peter@gmail.com",
      );
      when(
        mockRemoteDataSource.fetchUserData(),
      ).thenAnswer((_) async => Success(fakeDriver.toDriverDataEntity()));

      final result = await repository.fetchUserData();

      expect(result, isA<Success<DriverDataEntity?>>());
      final success = result as Success<DriverDataEntity?>;
      expect(success.data?.firstName, equals("Peter"));
      expect(success.data?.email, equals("peter@gmail.com"));
      verify(mockRemoteDataSource.fetchUserData()).called(1);
    },
  );

  test("fetchUserData returns Failure when remote data source fails", () async {
    // Arrange
    final fakeException = const ResponseException(message: "Some error");

    when(mockRemoteDataSource.fetchUserData())
        .thenAnswer((_) async => Failure(responseException: fakeException));

    // Act
    final result = await repository.fetchUserData();

    // Assert
    expect(result, isA<Failure<DriverDataEntity?>>());
    final failure = result as Failure<DriverDataEntity?>;
    expect(failure.responseException.message, equals("Some error"));

    verify(mockRemoteDataSource.fetchUserData()).called(1);
  });

}
