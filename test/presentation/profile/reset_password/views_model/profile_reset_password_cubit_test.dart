import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/profile_reset_password/profile_reset_password_response.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/requests/profile_reset_password/profile_reset_password_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/profile_reset_password/profile_reset_password_usecase.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_intent.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fake_form_state.dart';
import 'profile_reset_password_cubit_test.mocks.dart';

@GenerateMocks([GetProfileResetPasswordUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGetProfileResetPasswordUseCase getProfileResetPasswordUseCase;
  late ProfileResetPasswordCubit cubit;
  late Result<ProfileResetPasswordResponse> expectedSuccessResult;
  final request = const ProfileResetPasswordRequestEntity(
    password: 'Moaaz@123',
    newPassword: 'Moaaz@1234',
  );

  final expectedResponse = ProfileResetPasswordResponse(
    token: 'sample_token',
    message: 'Password Changed successfully',
  );
  setUpAll(() {
    getProfileResetPasswordUseCase = MockGetProfileResetPasswordUseCase();
  });
  setUp(() {
    cubit = ProfileResetPasswordCubit(getProfileResetPasswordUseCase);
    cubit.doIntent(InitializeProfileResetPasswordFormIntent());
    cubit.formKey = FakeGlobalKey(FakeFormState());
  });
  blocTest<ProfileResetPasswordCubit, ProfileResetPasswordState>(
    'should emit [loading, success] when ChangePassword is successful',
    build: () {
      expectedSuccessResult = Success<ProfileResetPasswordResponse>(
        expectedResponse,
      );
      provideDummy<Result<ProfileResetPasswordResponse>>(expectedSuccessResult);
      when(
        getProfileResetPasswordUseCase.execute(request),
      ).thenAnswer((_) async => expectedSuccessResult); // success
      return cubit;
    },
    act: (cubit) =>
        cubit.doIntent(OnProfileResetPasswordIntent(request: request)),
    expect: () => [
      const ProfileResetPasswordState(
        profileResetPasswordState: StateStatus.loading(),
      ),
      const ProfileResetPasswordState(
        profileResetPasswordState: StateStatus.success(null),
      ),
    ],
  );
}
