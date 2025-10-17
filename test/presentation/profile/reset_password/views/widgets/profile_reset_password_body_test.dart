import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views/widgets/build_profile_reset_password_form.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views/widgets/profile_reset_password_body.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'build_profile_reset_password_form_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockProfileResetPasswordCubit cubit;

  setUpAll(() {
    getIt.registerFactory<ProfileResetPasswordCubit>(() => cubit);
  });

  setUp(() {
    cubit = MockProfileResetPasswordCubit();
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
            value: cubit,
            child: const Scaffold(body: ProfileResetPasswordBody()),
          ),
        );
      },
    );
  }

  testWidgets('renders BuildProfileResetPasswordForm in initial state', (
    WidgetTester tester,
  ) async {
    // ARRANGE
    await tester.pumpWidget(prepareWidget());

    // ASSERT
    expect(find.byType(BuildProfileResetPasswordForm), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('shows loading dialog when state status is loading', (
    WidgetTester tester,
  ) async {
    // ARRANGE
    when(cubit.state).thenReturn(
      const ProfileResetPasswordState(
        profileResetPasswordState: StateStatus.loading(),
      ),
    );
    when(cubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const ProfileResetPasswordState(
          profileResetPasswordState: StateStatus.loading(),
        ),
      ]),
    );

    // ACT
    await tester.pumpWidget(prepareWidget());
    await tester.pump();

    // ASSERT
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
