import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/profile_reset_password/profile_reset_password_response.dart';
import 'package:flowery_tracking_app/data/data_source/profile_reset_password/profile_reset_password_data_source.dart';
import 'package:flowery_tracking_app/data/repositories/profile_reset_password/profile_reset_password_repository_impl.dart';
import 'package:flowery_tracking_app/domain/entities/requests/profile_reset_password/profile_reset_password_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_reset_password_repository_impl_test.mocks.dart';

@GenerateMocks([ProfileResetPasswordDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  changePassword from dataSource ', () async {
    final mockDataSource = MockProfileResetPasswordDataSource();
    final ProfileResetPasswordRepositoryImpl repo =
        ProfileResetPasswordRepositoryImpl(mockDataSource);

    final request = const ProfileResetPasswordRequestEntity(
      password: 'Moaaz@123',
      newPassword: 'Moaaz@1234',
    );

    final expectedResponse = ProfileResetPasswordResponse(
      token: 'sample_token',
      message: 'Password Changed successfully',
    );
    final expectedResult = Success(expectedResponse);
    provideDummy<Result<ProfileResetPasswordResponse>>(expectedResult);

    when(
      mockDataSource.profileResetPassword(request: request),
    ).thenAnswer((_) async => expectedResult);

    final result = await repo.profileResetPassword(request);

    verify(mockDataSource.profileResetPassword(request: request)).called(1);

    expect(result, isA<Success<ProfileResetPasswordResponse>>());

    result as Success<ProfileResetPasswordResponse>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
