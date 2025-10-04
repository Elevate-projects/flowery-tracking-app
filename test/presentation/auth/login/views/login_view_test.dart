import 'package:another_flushbar/flushbar.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views/login_view.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_tracking_app/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_view_test.mocks.dart';

@GenerateMocks([LoginCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockLoginCubit mockLoginCubit;
  setUp(() {
    mockLoginCubit = MockLoginCubit();
    getIt.registerFactory<LoginCubit>(() => mockLoginCubit);
    provideDummy<LoginState>(const LoginState());
    when(mockLoginCubit.state).thenReturn(const LoginState());
    when(
      mockLoginCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const LoginState()]));

    when(mockLoginCubit.loginFormKey).thenReturn(GlobalKey<FormState>());
    when(mockLoginCubit.emailController).thenReturn(TextEditingController());
    when(mockLoginCubit.passwordController).thenReturn(TextEditingController());
  });
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<LoginCubit>.value(
            value: mockLoginCubit
              ..doIntent(intent: InitializeLoginFormIntent()),
            child: const Scaffold(body: LoginView()),
          ),
        );
      },
    );
  }

  testWidgets("Verify Login Initial State UI", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(LoginView), findsOneWidget);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.text(AppText.login), findsOneWidget);
    expect(find.text(AppText.email), findsOneWidget);
    expect(find.text(AppText.password), findsOneWidget);
    expect(find.text(AppText.rememberMe), findsOneWidget);
    expect(find.text(AppText.forgetPassword), findsOneWidget);
    expect(find.text(AppText.continueText), findsOneWidget);
    expect(find.text(AppText.emailHint), findsOneWidget);
    expect(find.text(AppText.passwordHint), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(8));
    expect(find.byType(CustomTextFormField), findsNWidgets(2));
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomElevatedButton &&
            widget.buttonTitle == AppText.continueText,
      ),
      findsOneWidget,
    );
  });

  testWidgets("Verify Login Validation with empty fields State UI", (
    tester,
  ) async {
    // Arrange
    when(mockLoginCubit.doIntent(intent: anyNamed('intent'))).thenAnswer((
      invocation,
    ) {
      final intent = invocation.namedArguments[#intent];
      if (intent is EnableValidationIntent) {
        // manually trigger validation
        mockLoginCubit.loginFormKey.currentState?.validate();
      }
      return Future.value();
    });
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.tap(find.byKey(const Key("login_button")));
    await tester.pump();

    // Assert
    expect(find.text(AppText.emailValidation), findsOneWidget);
    expect(find.text(AppText.passwordValidation), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(10));
    expect(find.byType(CustomTextFormField), findsNWidgets(2));
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(CustomElevatedButton), findsOneWidget);
  });

  testWidgets("Verify Login Validation with wrong Inputs State UI", (
    tester,
  ) async {
    // Arrange
    when(mockLoginCubit.doIntent(intent: anyNamed('intent'))).thenAnswer((
      invocation,
    ) {
      final intent = invocation.namedArguments[#intent];
      if (intent is EnableValidationIntent) {
        // manually trigger validation
        mockLoginCubit.loginFormKey.currentState?.validate();
      }
      return Future.value();
    });
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField && widget.label == AppText.email,
      ),
      "ahmed@gmail",
    );
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField && widget.label == AppText.password,
      ),
      "ahmed",
    );
    await tester.tap(find.byKey(const Key("login_button")));
    await tester.pump();

    // Assert
    expect(find.text(AppText.emailValidation2), findsOneWidget);
    expect(find.text(AppText.passwordValidation2), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(10));
    expect(find.byType(CustomTextFormField), findsNWidgets(2));
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(CustomElevatedButton), findsOneWidget);
  });

  testWidgets("Verify Login loading State UI", (tester) async {
    // Arrange
    when(
      mockLoginCubit.state,
    ).thenReturn(const LoginState(loginStatus: StateStatus.loading()));
    when(mockLoginCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const LoginState(loginStatus: StateStatus.loading()),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField && widget.label == AppText.email,
      ),
      "ahmed@gmail.com",
    );
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField && widget.label == AppText.password,
      ),
      "Ahmed\$123",
    );

    // Assert
    expect(find.byType(Text), findsNWidgets(9));
    expect(find.byType(AnimationLoaderWidget), findsOneWidget);
    expect(find.text(AppText.loggingInMessage), findsOneWidget);
  });

  testWidgets("Verify Login failure State UI", (tester) async {
    // Arrange
    final ResponseException error = const ResponseException(
      message: "Failed to login",
    );
    when(
      mockLoginCubit.state,
    ).thenReturn(LoginState(loginStatus: StateStatus.failure(error)));
    when(mockLoginCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        LoginState(loginStatus: StateStatus.failure(error)),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField && widget.label == AppText.email,
      ),
      "ahmed@gmail.com",
    );
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is CustomTextFormField && widget.label == AppText.password,
      ),
      "Ahmed\$123",
    );

    // Assert
    expect(find.byType(Text), findsNWidgets(9));
    expect(find.text(error.message), findsOneWidget);
    expect(find.byType(Flushbar), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
