import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/login/remote_data_source/login_remote_data_source.dart';
import 'package:flowery_tracking_app/data/repositories/login/login_repository_impl.dart';
import 'package:flowery_tracking_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([LoginRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call login it should be called successfully from LoginRemoteDataSource',
    () async {
      // Arrange
      final mockedLoginRemoteDataSource = MockLoginRemoteDataSource();
      final loginRepositoryImpl = LoginRepositoryImpl(
        mockedLoginRemoteDataSource,
      );
      final request = LoginRequestEntity(
        email: "ahmed@gmail.com",
        password: "Ahmed\$123",
      );
      final expectedResult = Success<void>(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockedLoginRemoteDataSource.login(request: request),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await loginRepositoryImpl.login(request: request);

      // Assert
      verify(mockedLoginRemoteDataSource.login(request: request)).called(1);
      expect(result, isA<Success<void>>());
    },
  );
}
