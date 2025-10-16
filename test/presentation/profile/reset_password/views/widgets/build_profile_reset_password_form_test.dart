import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/domain/entities/requests/profile_reset_password/profile_reset_password_entity.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views/widgets/profile_reset_password_body.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_intent.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'build_profile_reset_password_form_test.mocks.dart';

@GenerateMocks([ProfileResetPasswordCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockProfileResetPasswordCubit cubit;

  setUpAll(() {
    getIt.registerFactory<ProfileResetPasswordCubit>(() => cubit);
  });
  setUp(() {
    cubit = MockProfileResetPasswordCubit();
    provideDummy<ProfileResetPasswordState>(const ProfileResetPasswordState());
    when(cubit.state).thenReturn(const ProfileResetPasswordState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    when(cubit.formKey).thenReturn(GlobalKey<FormState>());
    when(cubit.currentPasswordController).thenReturn(TextEditingController());
    when(cubit.newPasswordController).thenReturn(TextEditingController());
    when(cubit.confirmPasswordController).thenReturn(TextEditingController());
  });
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<ProfileResetPasswordCubit>.value(
            value: cubit..doIntent(InitializeProfileResetPasswordFormIntent()),
            child: const Scaffold(body: ProfileResetPasswordBody()),
          ),
        );
      },
    );
  }

  testWidgets('should render all text fields and update button correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(prepareWidget());
    expect(find.byType(Form), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField &&
            widget.label == AppText.currentPassword,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField &&
            widget.label == AppText.newPassword,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField &&
            widget.label == AppText.confirmPassword,
      ),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(CustomElevatedButton, AppText.update),
      findsOneWidget,
    );
  });
  testWidgets(
    'Verify ProfileResetPassword Validation with empty fields State UI',
    (tester) async {
      when(cubit.state).thenReturn(const ProfileResetPasswordState());
      when(cubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(prepareWidget());

      await tester.tap(find.text(AppText.update));
      cubit.formKey.currentState?.validate();
      cubit.doIntent(
        OnProfileResetPasswordIntent(
          request: ProfileResetPasswordRequestEntity(
            password: cubit.currentPasswordController.text,
            newPassword: cubit.confirmPasswordController.text,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(AppText.passwordValidation), findsNWidgets(2));
      expect(find.text(AppText.confirmPasswordValidation), findsOneWidget);
    },
  );
  testWidgets(
    'Verify ProfileResetPassword Validation with wrong Inputs State UI',
    (tester) async {
      when(cubit.state).thenReturn(const ProfileResetPasswordState());
      when(cubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(prepareWidget());

      await tester.enterText(
        find.byWidgetPredicate(
          (widget) =>
              widget is CustomTextFormField &&
              widget.label == AppText.currentPassword,
        ),
        "123",
      );
      await tester.enterText(
        find.byWidgetPredicate(
          (widget) =>
              widget is CustomTextFormField &&
              widget.label == AppText.newPassword,
        ),
        "123",
      );

      await tester.enterText(
        find.byWidgetPredicate(
          (widget) =>
              widget is CustomTextFormField &&
              widget.label == AppText.confirmPassword,
        ),
        "123",
      );

      await tester.tap(find.text(AppText.update));
      cubit.formKey.currentState?.validate();
      await tester.pump(); //
      cubit.doIntent(
        OnProfileResetPasswordIntent(
          request: ProfileResetPasswordRequestEntity(
            password: cubit.currentPasswordController.text,
            newPassword: cubit.confirmPasswordController.text,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(AppText.passwordValidation2), findsNWidgets(2));
    },
  );
}
