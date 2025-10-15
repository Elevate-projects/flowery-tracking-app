
import 'package:another_flushbar/flushbar.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart'
    show ResponseException;
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_state.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/apply_form.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/apply_form_button.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/apply_view_body.dart';
import 'package:flowery_tracking_app/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'apply_view_body_test.mocks.dart';

@GenerateMocks([ApplyCubit])
void main() {
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
    when(
      mockApplyCubit.doIntent(intent: anyNamed('intent')),
    ).thenAnswer((_) async {});

    when(mockApplyCubit.applyFormKey).thenReturn(GlobalKey<FormState>());
    when(
      mockApplyCubit.firstLegalNameController,
    ).thenReturn(TextEditingController());
    when(
      mockApplyCubit.secondLegalNameController,
    ).thenReturn(TextEditingController());
    when(
      mockApplyCubit.vehicleTypeLegalNameController,
    ).thenReturn(TextEditingController());
    when(
      mockApplyCubit.vehicleNumberController,
    ).thenReturn(TextEditingController());
    when(
      mockApplyCubit.vehicleLicenseController,
    ).thenReturn(TextEditingController());
    when(mockApplyCubit.emailController).thenReturn(TextEditingController());
    when(
      mockApplyCubit.phoneNumberController,
    ).thenReturn(TextEditingController());
    when(mockApplyCubit.idNumberController).thenReturn(TextEditingController());
    when(mockApplyCubit.idImageController).thenReturn(TextEditingController());
    when(mockApplyCubit.passwordController).thenReturn(TextEditingController());
    when(
      mockApplyCubit.confirmPasswordController,
    ).thenReturn(TextEditingController());
  });
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<ApplyCubit>.value(
            value: mockApplyCubit
              ..doIntent(intent: const ApplyInitializationIntent()),
            child: const Scaffold(body: ApplyViewBody()),
          ),
        );
      },
    );
  }

  testWidgets("Verify Structure", (WidgetTester tester) async {
    //AAA
    //ARRANGE
    await tester.pumpWidget(prepareWidget());
    await tester.pump();
    //ACT
    final applyViewBodyFinder = find.byType(ApplyViewBody);
    final singleChildScrollViewFinder = find.byType(SingleChildScrollView);
    final columnFinder = find.byType(Column);
    final applyFormFinder = find.byType(ApplyForm);
    final applyFormButtonFinder = find.byType(ApplyFormButton);
    find.descendant(
      of: find.byType(SingleChildScrollView),
      matching: find.byType(Column),
    );
    //ASSERT
    expect(applyViewBodyFinder, findsOneWidget);
    expect(singleChildScrollViewFinder, findsOneWidget);
    expect(columnFinder, findsNWidgets(2));
    expect(applyFormFinder, findsOneWidget);
    expect(applyFormButtonFinder, findsOneWidget);
    expect(find.byType(Text), findsNWidgets(28));
    expect(find.text('Welcome!!'), findsOneWidget);
    expect(
      find.text('You want to be a delivery man?\nJoin our team'),
      findsOneWidget,
    );
  });

  testWidgets("Verify Failure VehicleState", (WidgetTester tester) async {
    //AAA
    //ARRANGE
    when(mockApplyCubit.state).thenReturn(
      const ApplyState(
        vehicleStatus: StateStatus.failure(
          ResponseException(message: 'Vehicle not found'),
        ),
      ),
    );
    when(mockApplyCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const ApplyState(
          vehicleStatus: StateStatus.failure(
            ResponseException(message: 'Vehicle not found'),
          ),
        ),
      ]),
    );
    //ACT
    await tester.pumpWidget(prepareWidget());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    //ASSERT
    expect(find.byType(Flushbar<dynamic>), findsOneWidget);
    expect(find.text('Vehicle not found'), findsOneWidget);
  });

  testWidgets("Verify Failure CountryState", (WidgetTester tester) async {
    //AAA
    //ARRANGE
    when(mockApplyCubit.state).thenReturn(
      const ApplyState(
        countryStatus: StateStatus.failure(
          ResponseException(message: 'Country not found'),
        ),
      ),
    );
    when(mockApplyCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const ApplyState(
          countryStatus: StateStatus.failure(
            ResponseException(message: 'Country not found'),
          ),
        ),
      ]),
    );
    //ACT
    await tester.pumpWidget(prepareWidget());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    //ASSERT
    expect(find.byType(Flushbar<dynamic>), findsOneWidget);
    expect(find.text('Country not found'), findsOneWidget);
  });

  testWidgets("Verify Loading State", (WidgetTester tester) async {
  tester.view.physicalSize = const Size(1080, 1920);
  tester.view.devicePixelRatio = 1.0;

  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
    //AAA
    //ARRANGE
    when(mockApplyCubit.state).thenReturn(
      const ApplyState(
        applyStatus: StateStatus.loading(),
      ),
    );
    when(mockApplyCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const ApplyState(
          applyStatus: StateStatus.loading(),
        ),
      ]),
    );
    //ACT
    await tester.pumpWidget(prepareWidget());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    //ASSERT
    expect(find.byType(AnimationLoaderWidget), findsOneWidget);
    expect(find.byType(ModalBarrier), findsWidgets);
    expect(find.byType(PopScope), findsOneWidget);
  });

   testWidgets("Verify Failure applyState", (WidgetTester tester) async {
    //AAA
    //ARRANGE
    when(mockApplyCubit.state).thenReturn(
      const ApplyState(
        applyStatus: StateStatus.failure(
          ResponseException(message: 'Apply failed'),
        ),
      ),
    );
    when(mockApplyCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const ApplyState(
          applyStatus: StateStatus.failure(
            ResponseException(message: 'Apply failed'),
          ),
        ),
      ]),
    );
    //ACT
    await tester.pumpWidget(prepareWidget());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    //ASSERT
    expect(find.byType(Flushbar<dynamic>), findsOneWidget);
    expect(find.text('Apply failed'), findsOneWidget);
  });

  // test for navigation to application success screen in dev

  tearDown(() {
    getIt.reset();
  });
}
