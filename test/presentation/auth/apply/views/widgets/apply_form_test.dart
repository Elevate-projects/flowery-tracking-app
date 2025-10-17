import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_state.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/apply_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'apply_form_test.mocks.dart';

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
            child: const Scaffold(body: ApplyForm()),
          ),
        );
      },
    );
  }

  testWidgets('Verify ApplyForm Structure', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    //Arrange
    await tester.pumpWidget(prepareWidget());
    await tester.pump();

    final textFinder = find.byType(Text);
    final columnFinder = find.byType(Column);
    final formFinder = find.byType(Form);
    final textFormFieldFinder = find.byType(TextFormField);
    final dropdownButtonHideUnderlineFinder = find.byType(
      DropdownButtonHideUnderline,
    );
    final radioMenuButtonFinder = find.byType(RadioMenuButton<Gender>);

    //assert
    expect(formFinder, findsOneWidget);
    expect(columnFinder, findsWidgets);
    expect(textFinder, findsNWidgets(25));
    expect(textFormFieldFinder, findsNWidgets(10));
    expect(dropdownButtonHideUnderlineFinder, findsNWidgets(2));
    expect(radioMenuButtonFinder, findsNWidgets(2));
    expect(find.text(tr(AppText.gender)), findsOneWidget);
  });

  testWidgets('Verify empty fields', (WidgetTester tester) async {
       tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    //Arrange
    await tester.pumpWidget(prepareWidget());
    await tester.pump();

    final countryDropdown = find.byKey(const ValueKey('countryDropdown'));
    final vehicleDropdown = find.byKey(const ValueKey('vehicleDropdown'));
    final firstLegalNameField = find.byKey(const ValueKey('firstLegalName'));
    final secondLegalNameField = find.byKey(const ValueKey('secondLegalName'));
    final vehicleNumberField = find.byKey(const ValueKey('vehicleNumber'));
    final emailField = find.byKey(const ValueKey('email'));
    final phoneNumberField = find.byKey(const ValueKey('phoneNumber'));
    final idNumberField = find.byKey(const ValueKey('idNumber'));
    final passwordField = find.byKey(const ValueKey('password'));
    final confirmPasswordField = find.byKey(const ValueKey('confirmPassword'));
    final vehicleLicenseField = find.byKey(const ValueKey('vehicleLicense'));
    final idImageField = find.byKey(const ValueKey('idImage'));

    //assert
    expect(confirmPasswordField, findsOneWidget);
    expect(vehicleLicenseField, findsOneWidget);
    expect(idImageField, findsOneWidget);
    expect(firstLegalNameField, findsOneWidget);
    expect(secondLegalNameField, findsOneWidget);
    expect(vehicleNumberField, findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(phoneNumberField, findsOneWidget);
    expect(idNumberField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(countryDropdown, findsOneWidget);
    expect(vehicleDropdown, findsOneWidget);
  });

  testWidgets('Verify fields with valid data', (WidgetTester tester) async {
       tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    //Arrange
    await tester.pumpWidget(prepareWidget());
      await tester.enterText(
        find.byKey(const ValueKey('firstLegalName')),
        'ahmed',
      );
      await tester.enterText(
        find.byKey(const ValueKey('secondLegalName')),
        'omar',
      );
      await tester.enterText(
        find.byKey(const ValueKey('vehicleNumber')),
        '12345',
      );
      await tester.enterText(
        find.byKey(const ValueKey('email')),
        'ahmed@example.com',
      );
      await tester.enterText(
        find.byKey(const ValueKey('phoneNumber')),
        '0123456789',
      );
      await tester.enterText(
        find.byKey(const ValueKey('idNumber')),
        '987654321',
      );
      await tester.enterText(
        find.byKey(const ValueKey('password')),
        'Password123!',
      );
      await tester.enterText(
        find.byKey(const ValueKey('confirmPassword')),
        'Password123!',
      );
      await tester.enterText(
        find.byKey(const ValueKey('vehicleLicense')),
        'license.jpg',
      );
      await tester.enterText(
        find.byKey(const ValueKey('idImage')),
        'id.jpg',
      );
    await tester.pump();

    final countryDropdown = find.byKey(const ValueKey('countryDropdown'));
    final vehicleDropdown = find.byKey(const ValueKey('vehicleDropdown'));
    final firstLegalNameField = find.byKey(const ValueKey('firstLegalName'));
    final secondLegalNameField = find.byKey(const ValueKey('secondLegalName'));
    final vehicleNumberField = find.byKey(const ValueKey('vehicleNumber'));
    final emailField = find.byKey(const ValueKey('email'));
    final phoneNumberField = find.byKey(const ValueKey('phoneNumber'));
    final idNumberField = find.byKey(const ValueKey('idNumber'));
    final passwordField = find.byKey(const ValueKey('password'));
    final confirmPasswordField = find.byKey(const ValueKey('confirmPassword'));
    final vehicleLicenseField = find.byKey(const ValueKey('vehicleLicense'));
    final idImageField = find.byKey(const ValueKey('idImage'));

    //assert
    expect(confirmPasswordField, findsOneWidget);
    expect(vehicleLicenseField, findsOneWidget);
    expect(idImageField, findsOneWidget);
    expect(firstLegalNameField, findsOneWidget);
    expect(secondLegalNameField, findsOneWidget);
    expect(vehicleNumberField, findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(phoneNumberField, findsOneWidget);
    expect(idNumberField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(countryDropdown, findsOneWidget);
    expect(vehicleDropdown, findsOneWidget);
  });

  // need some modifications to the test below will add it to the viewbody later
//  testWidgets('Verify fields with invalid data', (WidgetTester tester) async {
// tester.view.physicalSize = const Size(1080, 2600);
//   tester.view.devicePixelRatio = 1.0;

//   addTearDown(() {
//     tester.view.resetPhysicalSize();
//     tester.view.resetDevicePixelRatio();
//   });

//   // Arrange
//   await tester.pumpWidget(prepareWidget());
//   await tester.pumpAndSettle();

//   await tester.enterText(find.byKey(const ValueKey('firstLegalName')), '');
//   await tester.enterText(find.byKey(const ValueKey('secondLegalName')), '');
//   await tester.enterText(find.byKey(const ValueKey('vehicleNumber')), '');
//   await tester.enterText(find.byKey(const ValueKey('email')), 'emailfake.com');
//   await tester.enterText(find.byKey(const ValueKey('phoneNumber')), '123');
//   await tester.enterText(find.byKey(const ValueKey('idNumber')), '');
//   await tester.enterText(find.byKey(const ValueKey('password')), 'pass');
//   await tester.enterText(find.byKey(const ValueKey('confirmPassword')), 'different-pass');
//   await tester.enterText(find.byKey(const ValueKey('vehicleLicense')), '');
//   await tester.enterText(find.byKey(const ValueKey('idImage')), '');

// (mockApplyCubit.applyFormKey.currentState!).validate();
// await tester.pumpAndSettle();

//   // Assertions
//   expect(find.byKey(const ValueKey('countryDropdown')), findsOneWidget);
//   expect(find.byKey(const ValueKey('vehicleDropdown')), findsOneWidget);
//   expect(find.byKey(const ValueKey('firstLegalName')), findsOneWidget);
//   expect(find.byKey(const ValueKey('secondLegalName')), findsOneWidget);
//   expect(find.byKey(const ValueKey('vehicleNumber')), findsOneWidget);
//   expect(find.byKey(const ValueKey('email')), findsOneWidget);
//   expect(find.byKey(const ValueKey('phoneNumber')), findsOneWidget);
//   expect(find.byKey(const ValueKey('idNumber')), findsOneWidget);
//   expect(find.byKey(const ValueKey('password')), findsOneWidget);
//   expect(find.byKey(const ValueKey('confirmPassword')), findsOneWidget);
//   expect(find.byKey(const ValueKey('vehicleLicense')), findsOneWidget);
//   expect(find.byKey(const ValueKey('idImage')), findsOneWidget);

//   expect(find.text('This field is required'), findsNWidgets(6));
//   expect(find.text('Password field should contain atleast 8 characters'), findsOneWidget);
//   expect(find.text('Enter a valid email'), findsOneWidget);
//   expect(find.text('Password does not match, please check the entered password'), findsOneWidget);
// });
  tearDown(() {
    getIt.reset();
  });
}
