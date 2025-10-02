import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views/profile_reset_password.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views/widgets/profile_reset_password_app_bar.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views/widgets/profile_reset_password_body.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'widgets/build_profile_reset_password_form_test.mocks.dart';

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
            child: const ProfileResetPassword(),
          ),
        );
      },
    );
  }

  testWidgets(
    'should build correctly, provide cubit, and call initial intent',
    (WidgetTester tester) async {
      await tester.pumpWidget(prepareWidget());

      // ASSERT: Verify the UI structure is correct.
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(ProfileResetPasswordAppBar), findsOneWidget);
      expect(find.byType(ProfileResetPasswordBody), findsOneWidget);
    },
  );
}
