import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/forget_password_and_resend_code/forget_password_and_resend_code_response.dart';
import 'package:flowery_tracking_app/api/responses/verification/verify_response.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/forget_password_and_resend_code/forget_password_and_resend_code_usecase.dart';
import 'package:flowery_tracking_app/domain/use_cases/verification/verification_usecase.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_state.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fake_form_state.dart';
import 'verification_screen_cubit_test.mocks.dart';

@GenerateMocks([GetVerificationUseCase, GetForgetPasswordResendCodeUseCase])
void main() {
  late MockGetVerificationUseCase getVerificationUseCase;
  late MockGetForgetPasswordResendCodeUseCase
  getForgetPasswordResendCodeUseCase;
  late ForgetPasswordAndResendCodeCubit cubit;
  late Result<ForgetPasswordAndResendCodeResponse> expectedSuccessResult;

  final verificationRequest = VerifyRequestEntity(resetCode: '123456');

  final resendCodeRequest = ForgetPasswordAndResendCodeRequestEntity(
    email: 'moaazhassan559@gmail.com',
  );
  final resendExpectedResponse = const ForgetPasswordAndResendCodeResponse(
    message: 'OTP Resented Successfully',
    info: 'Success',
  );
  final resendExpectedResult = Success<ForgetPasswordAndResendCodeResponse>(
    resendExpectedResponse,
  );
  final verificationExpectedResponse = const VerifyResponse(
    message: 'Verification Successful',
    code: 200,
    status: 'Success',
  );

  final verificationExpectedResult = Success<VerifyResponse>(
    verificationExpectedResponse,
  );
  setUp(() {
    getVerificationUseCase = MockGetVerificationUseCase();
    getForgetPasswordResendCodeUseCase =
        MockGetForgetPasswordResendCodeUseCase();
    provideDummy<Result<ForgetPasswordAndResendCodeResponse>>(
      resendExpectedResult,
    );
    provideDummy<Result<VerifyResponse>>(verificationExpectedResult);
    when(
      getForgetPasswordResendCodeUseCase.execute(resendCodeRequest),
    ).thenAnswer((_) async => resendExpectedResult);
    when(
      getVerificationUseCase.execute(verificationRequest),
    ).thenAnswer((_) async => verificationExpectedResult);
    cubit = ForgetPasswordAndResendCodeCubit(
      getForgetPasswordResendCodeUseCase,
    );
    cubit.doIntent(InitializeForgetPasswordFormIntent());
    cubit.formKey = FakeGlobalKey(FakeFormState());
  });
  blocTest<ForgetPasswordAndResendCodeCubit, ForgetPasswordAndResendCodeState>(
    'should emit [loading, success] when resend code  is successful',
    build: () {
      expectedSuccessResult = Success<ForgetPasswordAndResendCodeResponse>(
        resendExpectedResponse,
      );
      provideDummy<Result<ForgetPasswordAndResendCodeResponse>>(
        expectedSuccessResult,
      );
      when(
        getForgetPasswordResendCodeUseCase.execute(resendCodeRequest),
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
  blocTest<VerificationScreenCubit, VerificationScreenState>(
    'should emit [loading, success] when verification is successful',
    build: () => VerificationScreenCubit(
      getVerificationUseCase,
      getForgetPasswordResendCodeUseCase,
    ),
    act: (cubit) =>
        cubit.doIntent(OnVerificationIntent(request: verificationRequest)),
    expect: () => [
      const VerificationScreenState(verifyCodeStatus: StateStatus.loading()),
      const VerificationScreenState(
        verifyCodeStatus: StateStatus.success(null),
      ),
    ],
  );
}
