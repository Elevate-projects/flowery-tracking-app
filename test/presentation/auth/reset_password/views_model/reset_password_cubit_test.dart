import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/reset_password/reset_password_response.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/reset_password/reset_password_usecase.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fake_form_state.dart';
import 'reset_password_cubit_test.mocks.dart';

@GenerateMocks([GetResetPasswordUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGetResetPasswordUseCase getResetPasswordUseCase;
  late ResetPasswordCubit cubit;
  late Result<ResetPasswordResponse> expectedSuccessResult;

  final resetCodeRequest = ResetPasswordRequestEntity(
    email: 'moaazhassan559@gmail.com',
    newPassword: 'newPassword123',
  );

  final expectedResponse = const ResetPasswordResponse(
    token: 'newlyGeneratedToken',
    code: 200,
    message: 'Password reset successfully',
  );
  setUpAll(() {
    getResetPasswordUseCase = MockGetResetPasswordUseCase();
  });
  setUp(() {
    cubit = ResetPasswordCubit(getResetPasswordUseCase);
    cubit.doIntent(InitializeResetPasswordFormIntent());
    cubit.formKey = FakeGlobalKey(FakeFormState());
  });
  blocTest<ResetPasswordCubit, ResetPasswordState>(
    'should emit [loading, success] when reset code is successful',
    build: () {
      expectedSuccessResult = Success<ResetPasswordResponse>(expectedResponse);
      provideDummy<Result<ResetPasswordResponse>>(expectedSuccessResult);
      when(
        getResetPasswordUseCase.execute(resetCodeRequest),
      ).thenAnswer((_) async => expectedSuccessResult); // success
      return cubit;
    },
    act: (cubit) =>
        cubit.doIntent(OnResetPasswordIntent(request: resetCodeRequest)),
    expect: () => [
      const ResetPasswordState(resetPasswordState: StateStatus.loading()),
      const ResetPasswordState(resetPasswordState: StateStatus.success(null)),
    ],
  );
}
