import 'package:bloc_test/bloc_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view/edit_vehicle_view_body.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view_model/edit_vehicle_cubit.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view_model/edit_vehicle_status.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEditVehicleCubit extends MockCubit<EditVehicleStatus> implements EditVehicleCubit {}

void main() {
  late MockEditVehicleCubit mockEditVehicleCubit;

  setUp(() {
    mockEditVehicleCubit = MockEditVehicleCubit();
  });

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<EditVehicleCubit>(
            create: (context) => mockEditVehicleCubit,
            child: const EditVehicleViewBody(),
          ),
        );
      },
    );
  }

  group('EditVehicleViewBody', () {
    testWidgets('renders initial UI correctly', (WidgetTester tester) async {
      when(() => mockEditVehicleCubit.state).thenReturn(const EditVehicleStatus());
      when(() => mockEditVehicleCubit.formKey).thenReturn(GlobalKey<FormState>());
      when(() => mockEditVehicleCubit.vehicleTypeController).thenReturn(TextEditingController());
      when(() => mockEditVehicleCubit.vehicleNumberController).thenReturn(TextEditingController());
      when(() => mockEditVehicleCubit.vehicleLicenseController).thenReturn(TextEditingController());


      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(AppText.editVehicle.tr()), findsOneWidget);
      expect(find.byType(CustomTextFormField), findsNWidgets(3));
      expect(find.byType(CustomElevatedButton), findsOneWidget);
    });

    testWidgets('shows loading indicator when state is loading', (WidgetTester tester) async {
      when(() => mockEditVehicleCubit.state).thenReturn(const EditVehicleStatus());
      when(() => mockEditVehicleCubit.formKey).thenReturn(GlobalKey<FormState>());
      when(() => mockEditVehicleCubit.vehicleTypeController).thenReturn(TextEditingController());
      when(() => mockEditVehicleCubit.vehicleNumberController).thenReturn(TextEditingController());
      when(() => mockEditVehicleCubit.vehicleLicenseController).thenReturn(TextEditingController());


      await tester.pumpWidget(createWidgetUnderTest());
    });

    testWidgets('shows success message when state is success', (WidgetTester tester) async {
      whenListen(
        mockEditVehicleCubit,
        Stream.fromIterable([
          const EditVehicleStatus(),
        ]),
        initialState: const EditVehicleStatus(),
      );
      when(() => mockEditVehicleCubit.formKey).thenReturn(GlobalKey<FormState>());
      when(() => mockEditVehicleCubit.vehicleTypeController).thenReturn(TextEditingController());
      when(() => mockEditVehicleCubit.vehicleNumberController).thenReturn(TextEditingController());
      when(() => mockEditVehicleCubit.vehicleLicenseController).thenReturn(TextEditingController());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
    });

    testWidgets('shows error message when state is failure', (WidgetTester tester) async {
      whenListen(
        mockEditVehicleCubit,
        Stream.fromIterable([
          const EditVehicleStatus(),
        ]),
        initialState: const EditVehicleStatus(),
      );
      when(() => mockEditVehicleCubit.formKey).thenReturn(GlobalKey<FormState>());
      when(() => mockEditVehicleCubit.vehicleTypeController).thenReturn(TextEditingController());
      when(() => mockEditVehicleCubit.vehicleNumberController).thenReturn(TextEditingController());
      when(() => mockEditVehicleCubit.vehicleLicenseController).thenReturn(TextEditingController());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
    });
  });
}
