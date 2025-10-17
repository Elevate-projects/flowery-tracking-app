import 'package:flowery_tracking_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_intent.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'edit_profile_cubit_test.mocks.dart';
@GenerateMocks([EditProfileUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late EditProfileCubit cubit;
  late MockEditProfileUseCase mockUseCase;
  setUp(() {
    mockUseCase = MockEditProfileUseCase();
    cubit = EditProfileCubit(mockUseCase);
  });
  tearDown(() {
    cubit.close();
  });
  group('EditProfileCubit', () {
    test('initial state is correct (assuming no initial data)', () {
      cubit.doIntent(intent: InitializeEditProfile());
      expect(cubit.state.isFormValid, isFalse);
      expect(cubit.state.editProfileStatus.isInitial, isTrue);
    });
    test('isFormValid becomes true when all fields are filled', () {
      cubit.doIntent(intent: InitializeEditProfile());
      // Arrange: Start with an invalid form
      expect(cubit.state.isFormValid, isFalse);
      // Act: Fill all controllers
      cubit.firstNameController.text = 'John';
      cubit.lastNameController.text = 'Doe';
      cubit.emailController.text = "william.r.king@my-own-personal-domain.com";
      cubit.phoneController.text = '+201234567890';
      cubit.passwordController.text = 'password123';
      // Assert: The form should now be valid
      expect(cubit.state.isFormValid, isTrue);
    });
    test("will test doIntent method", () {
      cubit.doIntent(intent: InitializeEditProfile());
      expect(cubit.state.isFormValid, isFalse);
      cubit.doIntent(intent: EnterThePassword());
      expect(cubit.state.isFormValid, isFalse);
      cubit.doIntent(intent: SubmitEditProfile());
      expect(cubit.state.isFormValid, isFalse);
    },);
    test("testing isObscure method", () {
      /// for inzaltion of password controller
      cubit.doIntent(intent: InitializeEditProfile());
      cubit.doIntent(intent: IsObscure());
      expect(cubit.state.isObscure, isTrue);
    },);
    test("testing enterThePassword method", () {
      /// for inzaltion of password controller
      cubit.doIntent(intent: InitializeEditProfile());
      cubit.doIntent(intent: EnterThePassword());
      expect(cubit.state.isObscure, isFalse);
    },);
    test("testing submitEditProfile method", () {
      /// for initialization of password controller
      cubit.doIntent(intent: InitializeEditProfile());
      cubit.doIntent(intent: SubmitEditProfile());
      expect(cubit.state.isFormValid, isFalse);
    });
    test('isFormValid becomes false if a field is cleared', () {
      // Arrange: Start with a valid form
      cubit.doIntent(intent: InitializeEditProfile());
      cubit.firstNameController.text = 'John';
      cubit.lastNameController.text = 'Doe';
      cubit.emailController.text = "william.henry.harrison@example-pet-store.com";
      cubit.phoneController.text = '+201234567890';
      cubit.passwordController.text = 'password123';
      expect(cubit.state.isFormValid, isTrue,);
      // Act: Clear one of the controllers
      cubit.firstNameController.clear();
      // Assert: The form should now be invalid
      expect(cubit.state.isFormValid, isFalse);
    });
  });
}