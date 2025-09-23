import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/login/login_repository.dart';
import 'package:flowery_tracking_app/domain/use_cases/login/login_with_email_and_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_with_email_and_password_use_case_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call invoke it should be called successfully from LoginRepository',
    () async {
      //Arrange
      final mockedLoginRepository = MockLoginRepository();
      final loginUseCase = LoginWithEmailAndPasswordUseCase(
        mockedLoginRepository,
      );
      final request = LoginRequestEntity(
        email: "ahmed@gmail.com",
        password: "Ahmed\$123",
      );
      final expectedResult = Success<void>(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        loginUseCase.invoke(request: request),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await loginUseCase.invoke(request: request);

      // Assert
      verify(mockedLoginRepository.login(request: request)).called(1);
      expect(result, isA<Success<void>>());
    },
  );
}
