import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views/forget_password.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_test.mocks.dart';

@GenerateMocks([ForgetPasswordAndResendCodeCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockForgetPasswordAndResendCodeCubit cubit;
  setUpAll(() {
    getIt.registerFactory<ForgetPasswordAndResendCodeCubit>(() => cubit);
  });

  setUp(() {
    cubit = MockForgetPasswordAndResendCodeCubit();
    provideDummy<ForgetPasswordAndResendCodeState>(
      const ForgetPasswordAndResendCodeState(),
    );
    when(cubit.state).thenReturn(const ForgetPasswordAndResendCodeState());
    when(cubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const ForgetPasswordAndResendCodeState()]),
    );

    when(cubit.formKey).thenReturn(GlobalKey<FormState>());
    when(cubit.emailController).thenReturn(TextEditingController());
  });
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<ForgetPasswordAndResendCodeCubit>.value(
            value: cubit..doIntent(const InitializeForgetPasswordFormIntent()),
            child: const Scaffold(body: ForgetPassword()),
          ),
        );
      },
    );
  }

  testWidgets('Verify ForgetPassword Initial State UI', (tester) async {
    await tester.pumpWidget(prepareWidget());
    //Assert
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(6));
    expect(find.byType(CustomTextFormField), findsNWidgets(1));
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
  testWidgets('Verify ForgetPassword Validation with empty fields State UI', (
    tester,
  ) async {
    when(cubit.state).thenReturn(const ForgetPasswordAndResendCodeState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(prepareWidget());

    await tester.tap(find.text(AppText.confirmWord));
    cubit.formKey.currentState?.validate();

    cubit.doIntent(
      OnConfirmEmailClickIntent(
        request: ForgetPasswordAndResendCodeRequestEntity(
          email: cubit.emailController.text,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(AppText.emailValidation), findsOneWidget);
  });

  testWidgets('Verify ForgetPassword Validation with wrong Inputs State UI', (
    tester,
  ) async {
    when(cubit.state).thenReturn(const ForgetPasswordAndResendCodeState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(prepareWidget());

    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField && widget.label == AppText.email,
      ),
      "invalid-email-format",
    );

    await tester.tap(find.text(AppText.confirmWord));
    cubit.formKey.currentState?.validate();

    cubit.doIntent(
      OnConfirmEmailClickIntent(
        request: ForgetPasswordAndResendCodeRequestEntity(
          email: cubit.emailController.text,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(AppText.emailValidation2), findsOneWidget);
  });

  testWidgets('verify forgetPassword loading state UI', (tester) async {
    //Arrange
    when(cubit.state).thenReturn(
      const ForgetPasswordAndResendCodeState(
        forgetPasswordAndResendCodeStatus: StateStatus.loading(),
      ),
    );
    when(cubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const ForgetPasswordAndResendCodeState(
          forgetPasswordAndResendCodeStatus: StateStatus.loading(),
        ),
      ]),
    );
    await tester.pumpWidget(prepareWidget());
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField && widget.label == AppText.email,
      ),
      "moaaz@gmail.com",
    );

    // Assert
    expect(find.byType(Text), findsNWidgets(6));
  });
  testWidgets("Verify forgetPassword failure State UI", (tester) async {
    // Arrange
    final ResponseException error = const ResponseException(
      message: "Failed to ForgetPassword",
    );
    when(cubit.state).thenReturn(
      ForgetPasswordAndResendCodeState(
        forgetPasswordAndResendCodeStatus: StateStatus.failure(error),
      ),
    );
    when(cubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        ForgetPasswordAndResendCodeState(
          forgetPasswordAndResendCodeStatus: StateStatus.failure(error),
        ),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField && widget.label == AppText.email,
      ),
      "moaaz@gmail.com",
    );

    // Assert
    expect(find.byType(Text), findsNWidgets(7));
    expect(find.text(error.message), findsOneWidget);
  });
}
