import 'package:flowery_tracking_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/profile/get_profile_data_use_case.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([GetProfileDataUseCase, GlobalCubit])
void main() {
  late ProfileCubit cubit;
  late MockGetProfileDataUseCase mockUseCase;
  late MockGlobalCubit mockGlobalCubit;

  setUp(() {
    mockUseCase = MockGetProfileDataUseCase();
    mockGlobalCubit = MockGlobalCubit();
    when(mockGlobalCubit.isArLanguage).thenReturn(false);
    provideDummy<DriverDataEntity?>(DriverDataEntity());
    provideDummy<Result<DriverDataEntity?>>(Success(DriverDataEntity()));

    cubit = ProfileCubit(mockUseCase);
    FloweryDriverMethodHelper.currentUserToken = "fake_token";
    FloweryDriverMethodHelper.driverData = null;
  });

  group('ProfileCubit Tests', () {
    test("Initial state is correct", () {

      expect(cubit.state.selectedLanguage, Languages.english);
      expect(cubit.state.profileStatus, const StateStatus<DriverDataEntity?>.initial());
    });

    test("ProfileInitializationIntent sets language and fetches profile data", () async {
      final driver = DriverDataEntity(firstName: "Peter", email: "peter@gmail.com");
      when(mockUseCase.call()).thenAnswer((_) async => Success(driver));

      await cubit.doIntent(ProfileInitializationIntent(globalCubit: mockGlobalCubit));

      expect(cubit.state.selectedLanguage, Languages.english);
      expect(cubit.state.profileStatus.data, driver);
      expect(FloweryDriverMethodHelper.driverData, driver);
    });

    test("GetUserProfileDataIntent sets profileStatus to Success", () async {
      final driver = DriverDataEntity(firstName: "Peter", email: "peter@gmail.com");
      when(mockUseCase.call()).thenAnswer((_) async => Success(driver));

      await cubit.doIntent(GetUserProfileDataIntent());

      expect(cubit.state.profileStatus, isA<StateStatus>().having((s) => s.data, "driver", driver));
      verify(mockUseCase.call()).called(1);
    });

    test("GetUserProfileDataIntent sets profileStatus to Failure when use case fails", () async {
      final responseException = const ResponseException(message: "Failed");
      when(mockUseCase.call()).thenAnswer((_) async => Failure(responseException: responseException));

      await cubit.doIntent(GetUserProfileDataIntent());

      expect(cubit.state.profileStatus, isA<StateStatus>().having((s) => s.error?.message, "error message", "Failed"));
      verify(mockUseCase.call()).called(1);
    });

    test("ToggleLanguageIntent changes the selected language", () async {
      when(mockGlobalCubit.doIntent(intent: anyNamed('intent'))).thenAnswer((_) async {});

      cubit.emit(cubit.state.copyWith(selectedLanguage: Languages.english));
      await cubit.doIntent(ToggleLanguageIntent(globalCubit: mockGlobalCubit, newSelectedLanguage: Languages.arabic));

      expect(cubit.state.selectedLanguage, Languages.arabic);
      verify(mockGlobalCubit.doIntent(intent: anyNamed('intent'))).called(1);
    });

    test("ToggleLanguageIntent does not change language if same as current", () async {
      cubit.emit(cubit.state.copyWith(selectedLanguage: Languages.english));
      await cubit.doIntent(ToggleLanguageIntent(globalCubit: mockGlobalCubit, newSelectedLanguage: Languages.english));

      expect(cubit.state.selectedLanguage, Languages.english);
      verifyNever(mockGlobalCubit.doIntent(intent: anyNamed('intent')));
    });
  });
}
