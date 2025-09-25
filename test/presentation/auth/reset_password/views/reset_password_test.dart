import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views/reset_password.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_test.mocks.dart';

@GenerateMocks([ResetPasswordCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockResetPasswordCubit cubit;
  setUpAll(() {
    getIt.registerFactory<ResetPasswordCubit>(() => cubit);
  });

  setUp(() {
    cubit = MockResetPasswordCubit();
    provideDummy<ResetPasswordState>(const ResetPasswordState());
    when(cubit.state).thenReturn(const ResetPasswordState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    when(cubit.formKey).thenReturn(GlobalKey<FormState>());
    when(cubit.passwordController).thenReturn(TextEditingController());
    when(cubit.confirmPasswordController).thenReturn(TextEditingController());
  });

  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<ResetPasswordCubit>.value(
            value: cubit..doIntent(InitializeResetPasswordFormIntent()),
            child: const Scaffold(
              body: ResetPassword(email: 'moaazhassan559@gmail.com'),
            ),
          ),
        );
      },
    );
  }

  testWidgets('Verify ResetPassword Initial State UI', (tester) async {
    await tester.pumpWidget(prepareWidget());
    //Assert
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(8));
    expect(find.byType(CustomTextFormField), findsNWidgets(2));
    expect(find.byType(CustomElevatedButton), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomElevatedButton &&
            widget.buttonTitle == AppText.confirmWord,
      ),
      findsOneWidget,
    );
  });
  testWidgets('Verify ResetPassword Validation with empty fields State UI', (
    tester,
  ) async {
    when(cubit.state).thenReturn(const ResetPasswordState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(prepareWidget());

    await tester.tap(find.text(AppText.confirmWord));
    cubit.formKey.currentState?.validate();
    cubit.doIntent(
      OnResetPasswordIntent(
        request: ResetPasswordRequestEntity(
          email: 'moaazhassan559@gmail.com',
          newPassword: cubit.confirmPasswordController.text,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(AppText.passwordValidation), findsOneWidget);
    expect(find.text(AppText.confirmPasswordValidation), findsOneWidget);
  });

  testWidgets('Verify ResetPassword Validation with wrong Inputs State UI', (
    tester,
  ) async {
    when(cubit.state).thenReturn(const ResetPasswordState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(prepareWidget());

    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField && widget.label == AppText.password,
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

    await tester.tap(find.text(AppText.confirmWord));
    cubit.formKey.currentState?.validate();
    await tester.pump(); //
    cubit.doIntent(
      OnResetPasswordIntent(
        request: ResetPasswordRequestEntity(
          email: 'moaazhassan559@gmail.com',
          newPassword: cubit.confirmPasswordController.text,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(AppText.passwordValidation2), findsNWidgets(1));
  });

  testWidgets('verify forgetPassword loading state UI', (tester) async {
    //Arrange
    when(cubit.state).thenReturn(
      const ResetPasswordState(resetPasswordState: StateStatus.loading()),
    );
    when(cubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const ResetPasswordState(resetPasswordState: StateStatus.loading()),
      ]),
    );
    await tester.pumpWidget(prepareWidget());
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField && widget.label == AppText.password,
      ),
      "Moaaz@123",
    );
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField &&
            widget.label == AppText.confirmPassword,
      ),
      "Moaaz@123",
    );

    // Assert
    expect(find.byType(Text), findsNWidgets(8));
  });
  testWidgets("Verify ResetPassword failure State UI", (tester) async {
    // Arrange
    final ResponseException error = const ResponseException(
      message: "Failed to ResetPassword",
    );
    when(cubit.state).thenReturn(
      ResetPasswordState(resetPasswordState: StateStatus.failure(error)),
    );
    when(cubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        ResetPasswordState(resetPasswordState: StateStatus.failure(error)),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField && widget.label == AppText.password,
      ),
      "Moaaz@123",
    );
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField &&
            widget.label == AppText.confirmPassword,
      ),
      "Moaaz@123",
    );

    // Assert
    expect(find.byType(Text), findsNWidgets(9));
    expect(find.text(error.message), findsOneWidget);
  });
}
