import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/forget_password_and_resend_code/forget_password_and_resend_code_response.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/forget_password_and_resend_code/forget_password_and_resend_code_usecase.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fake_form_state.dart';
import 'forget_password_and_resend_code_cubit_test.mocks.dart';

@GenerateMocks([GetForgetPasswordResendCodeUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGetForgetPasswordResendCodeUseCase getResendCodeUseCase;
  late ForgetPasswordAndResendCodeCubit cubit;
  late Result<ForgetPasswordAndResendCodeResponse> expectedSuccessResult;

  final resendCodeRequest = const ForgetPasswordAndResendCodeRequestEntity(
    email: 'moaazhassan559@gmail.com',
  );
  final resendExpectedResponse = const ForgetPasswordAndResendCodeResponse(
    message: 'OTP Resented Successfully',
    info: 'Success',
  );

  setUpAll(() {
    getResendCodeUseCase = MockGetForgetPasswordResendCodeUseCase();
  });
  setUp(() {
    cubit = ForgetPasswordAndResendCodeCubit(getResendCodeUseCase);
    cubit.doIntent(const InitializeForgetPasswordFormIntent());
    cubit.formKey = FakeGlobalKey(FakeFormState());
  });
  group('ForgetPasswordAndResendCodeCubit', () {
    blocTest<
      ForgetPasswordAndResendCodeCubit,
      ForgetPasswordAndResendCodeState
    >(
      'emits [loading, success] when forget password is successful',
      build: () {
        expectedSuccessResult = Success<ForgetPasswordAndResendCodeResponse>(
          resendExpectedResponse,
        );
        provideDummy<Result<ForgetPasswordAndResendCodeResponse>>(
          expectedSuccessResult,
        );
        when(
          getResendCodeUseCase.execute(resendCodeRequest),
        ).thenAnswer((_) async => expectedSuccessResult); // success
        return cubit;
      },
      act: (cubit) {
        cubit.doIntent(OnConfirmEmailClickIntent(request: resendCodeRequest));
      },
      expect: () => [
        const ForgetPasswordAndResendCodeState(
          forgetPasswordAndResendCodeStatus: StateStatus.loading(),
        ),
        const ForgetPasswordAndResendCodeState(
          forgetPasswordAndResendCodeStatus: StateStatus.success(null),
        ),
      ],
    );
  });
}
