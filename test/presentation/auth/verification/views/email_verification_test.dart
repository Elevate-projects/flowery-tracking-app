import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views/email_verification.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'email_verification_test.mocks.dart';

@GenerateMocks([VerificationScreenCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockVerificationScreenCubit cubit;
  setUpAll(() {
    getIt.registerFactory<VerificationScreenCubit>(() => cubit);
  });

  setUp(() {
    cubit = MockVerificationScreenCubit();
    provideDummy<VerificationScreenState>(const VerificationScreenState());
    when(cubit.state).thenReturn(const VerificationScreenState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<VerificationScreenCubit>.value(
            value: cubit,
            child: const EmailVerificationView(email: ''),
          ),
        );
      },
    );
  }

  testWidgets('Verify Verification Initial State UI', (tester) async {
    await tester.pumpWidget(prepareWidget());
    //Assert
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(12));
    expect(find.byType(PinCodeTextField), findsNWidgets(1));
  });
  testWidgets('shows resend text when secondsRemaining > 0', (tester) async {
    when(
      cubit.state,
    ).thenReturn(const VerificationScreenState(secondsRemaining: 10));
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(prepareWidget());
    await tester.pump();
    find.byWidgetPredicate(
      (widget) => widget is Text && widget.selectionColor == AppColors.pink,
    );
  });
  testWidgets('calls OnVerificationIntent when 6-digit code completed', (
    tester,
  ) async {
    when(cubit.state).thenReturn(const VerificationScreenState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());
    await tester.pumpWidget(prepareWidget());

    // Find the PinCodeTextFiledWidget and enter 6 digits
    final pinFinder = find.byType(TextField).first;
    await tester.enterText(pinFinder, '123456');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    // let debounce timers run
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();

    cubit.doIntent(
      OnVerificationIntent(request: VerifyRequestEntity(resetCode: '123456')),
    );
  });

  testWidgets('calls OnResendCodeClickIntent when resend tapped', (
    tester,
  ) async {
    when(
      cubit.state,
    ).thenReturn(const VerificationScreenState(secondsRemaining: 0));

    await tester.pumpWidget(prepareWidget());

    // Tap the resend button (inside ResendCodeRow)
    final resendFinder = find.byWidgetPredicate(
      (widget) => widget is Text && widget.data == AppText.resendWord,
    );
    await tester.tap(resendFinder);
    await tester.pump();

    cubit.doIntent(
      OnResendCodeClickIntent(
        request: ForgetPasswordAndResendCodeRequestEntity(
          email: 'moaazhassan559@gmail.com',
        ),
      ),
    );
  });
}
