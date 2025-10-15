import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_state.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/apply_view.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/apply_app_bar.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/apply_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'apply_view_test.mocks.dart';

@GenerateMocks([ApplyCubit])
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockApplyCubit mockApplyCubit;
  setUp(() {
    mockApplyCubit = MockApplyCubit();
    getIt.registerFactory<ApplyCubit>(() => mockApplyCubit);
    provideDummy<ApplyState>(const ApplyState());
    when(mockApplyCubit.state).thenReturn(const ApplyState());
    when(
      mockApplyCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const ApplyState()]));
     when(mockApplyCubit.doIntent(intent: anyNamed('intent')))
        .thenAnswer((_) async {});
        
          when(mockApplyCubit.applyFormKey).thenReturn(GlobalKey<FormState>());

    when(mockApplyCubit.firstLegalNameController)
        .thenReturn(TextEditingController());
    when(mockApplyCubit.secondLegalNameController)
        .thenReturn(TextEditingController());
    when(mockApplyCubit.vehicleTypeLegalNameController)
        .thenReturn(TextEditingController());
    when(mockApplyCubit.vehicleNumberController)
        .thenReturn(TextEditingController());
    when(mockApplyCubit.vehicleLicenseController)
        .thenReturn(TextEditingController());
    when(mockApplyCubit.emailController)
        .thenReturn(TextEditingController());
    when(mockApplyCubit.phoneNumberController)
        .thenReturn(TextEditingController());
    when(mockApplyCubit.idNumberController)
        .thenReturn(TextEditingController());
    when(mockApplyCubit.idImageController)
        .thenReturn(TextEditingController());
    when(mockApplyCubit.passwordController)
        .thenReturn(TextEditingController());
    when(mockApplyCubit.confirmPasswordController)
        .thenReturn(TextEditingController());

  });

  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<ApplyCubit>.value(
            value: mockApplyCubit
              ..doIntent(intent: const ApplyInitializationIntent()),
            child: const Scaffold(body: ApplyView()),
          ),
        );
      },
    );
  }

  testWidgets('Verify ApplyView Structure', (WidgetTester tester) async {
      await tester.pumpWidget(prepareWidget());
        await tester.pump();
      expect(find.byType(ApplyAppBar), findsOneWidget);
      expect(find.byType(ApplyViewBody), findsOneWidget);
  });
}
