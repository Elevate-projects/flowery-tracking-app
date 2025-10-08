import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/cache/shared_preferences_helper.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_tracking_app/domain/use_cases/fetch_all_driver_orders/fetch_all_driver_orders_use_case.dart';
import 'package:flowery_tracking_app/domain/use_cases/login/login_with_email_and_password_use_case.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fake_form_state.dart';
import 'login_cubit_test.mocks.dart';

@GenerateMocks([
  LoginWithEmailAndPasswordUseCase,
  FetchAllDriverOrdersUseCase,
  SecureStorage,
  SharedPreferencesHelper,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockLoginWithEmailAndPasswordUseCase
  mockLoginWithEmailAndPasswordUseCase;
  late MockFetchAllDriverOrdersUseCase mockFetchAllDriverOrdersUseCase;
  late MockSecureStorage mockSecureStorage;
  late MockSharedPreferencesHelper mockSharedPreferencesHelper;
  late LoginCubit cubit;
  late Result<void> expectedSuccessResult;
  late Result<String?> expectedSuccessResult2;
  late Failure<void> expectedFailureResult;

  setUpAll(() {
    mockLoginWithEmailAndPasswordUseCase =
        MockLoginWithEmailAndPasswordUseCase();
    mockFetchAllDriverOrdersUseCase = MockFetchAllDriverOrdersUseCase();
    mockSecureStorage = MockSecureStorage();
    mockSharedPreferencesHelper = MockSharedPreferencesHelper();
    when(
      mockSharedPreferencesHelper.getBool(key: ConstKeys.rememberMe),
    ).thenAnswer((_) => true);
    when(
      mockSecureStorage.getData(key: ConstKeys.email),
    ).thenAnswer((_) async => "ahmed@gmail.com");
    when(
      mockSecureStorage.getData(key: ConstKeys.password),
    ).thenAnswer((_) async => "Ahmed\$123");
  });
  setUp(() {
    cubit = LoginCubit(
      mockLoginWithEmailAndPasswordUseCase,
      mockSecureStorage,
      mockSharedPreferencesHelper,
      mockFetchAllDriverOrdersUseCase,
    );
    cubit.doIntent(intent: InitializeLoginFormIntent());
    cubit.loginFormKey = FakeGlobalKey(FakeFormState());
  });

  group("Login cubit test", () {
    blocTest<LoginCubit, LoginState>(
      'emits [Loading, Success] when LoginWithEmailAndPasswordIntent succeeds',
      build: () {
        expectedSuccessResult = Success<void>(null);
        expectedSuccessResult2 = Success<String?>("123450");
        provideDummy<Result<void>>(expectedSuccessResult);
        provideDummy<Result<String?>>(expectedSuccessResult2);
        when(
          mockLoginWithEmailAndPasswordUseCase.invoke(
            request: anyNamed("request"),
          ),
        ).thenAnswer((_) async => expectedSuccessResult);
        when(
          mockFetchAllDriverOrdersUseCase.invoke(),
        ).thenAnswer((_) async => expectedSuccessResult2);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent: LoginWithEmailAndPasswordIntent()),
      expect: () => [
        isA<LoginState>().having(
          (state) => state.loginStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<LoginState>().having(
          (state) => state.loginStatus.isSuccess,
          "Is Success State",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockLoginWithEmailAndPasswordUseCase.invoke(
            request: anyNamed("request"),
          ),
        ).called(1);
        verify(mockFetchAllDriverOrdersUseCase.invoke()).called(1);
      },
    );

    blocTest(
      "emits [Loading, Failure] when LoginWithEmailAndPasswordIntent is Called",
      build: () {
        expectedFailureResult = Failure(
          responseException: const ResponseException(
            message: "failed to login",
          ),
        );
        provideDummy<Result<void>>(expectedFailureResult);
        when(
          mockLoginWithEmailAndPasswordUseCase.invoke(
            request: anyNamed("request"),
          ),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent: LoginWithEmailAndPasswordIntent()),
      expect: () => [
        isA<LoginState>().having(
          (state) => state.loginStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<LoginState>()
            .having(
              (state) => state.loginStatus.isFailure,
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.loginStatus.error?.message,
              'responseException.message',
              expectedFailureResult.responseException.message,
            ),
      ],
      verify: (_) {
        verify(
          mockLoginWithEmailAndPasswordUseCase.invoke(
            request: anyNamed("request"),
          ),
        ).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'Change password visibility when ToggleObscurePasswordIntent',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(intent: ToggleObscurePasswordIntent()),
      expect: () => [
        isA<LoginState>().having(
          (state) => state.isObscure,
          'when toggle password obscure its value will be changed to false',
          false,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'Change remember me value when ToggleRememberMeIntent',
      build: () => cubit,
      act: (cubit) async =>
          await cubit.doIntent(intent: ToggleRememberMeIntent()),
      expect: () => [
        isA<LoginState>().having(
          (state) => state.rememberMe,
          "Is remember me value changed",
          equals(false),
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'Check isContinueClickedWhenDisabled value when CheckFieldsValidationIntent',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(intent: CheckFieldsValidationIntent()),
      expect: () => [
        isA<LoginState>()
            .having(
              (state) => state.isContinueClickedWhenDisabled,
              "Is ContinueClickedWhenDisabled value = false",
              equals(false),
            )
            .having(
              (state) => state.isValidToLogin,
              "Is ValidToLogin value = true",
              equals(true),
            ),
      ],
    );
    blocTest<LoginCubit, LoginState>(
      'Check isContinueClickedWhenDisabled value when EnableValidationIntent',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(intent: EnableValidationIntent()),
      expect: () => [
        isA<LoginState>(),
        isA<LoginState>()
            .having(
              (state) => state.isContinueClickedWhenDisabled,
              "Is ContinueClickedWhenDisabled value = true",
              equals(true),
            )
            .having(
              (state) => state.isValidToLogin,
              "Is ValidToLogin value = true",
              equals(true),
            ),
      ],
    );
  });
}
