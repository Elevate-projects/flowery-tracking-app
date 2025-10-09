import 'package:flowery_tracking_app/core/constants/widget_keys.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_state.dart';
import 'package:flowery_tracking_app/presentation/profile/views/profile_views.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_views_test.mocks.dart';

@GenerateMocks([ProfileCubit, GlobalCubit])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockProfileCubit cubit;
  late MockGlobalCubit globalCubit;
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });
  setUp(() {
    getIt.reset();
    cubit = MockProfileCubit();
    globalCubit = MockGlobalCubit();
    getIt.registerFactory<ProfileCubit>(() => cubit);
    getIt.registerFactory<GlobalCubit>(() => globalCubit);
    provideDummy<ProfileState>(const ProfileState());
    provideDummy<GlobalState>(GlobalInitial());

    when(cubit.state).thenReturn(const ProfileState());
    when(
      cubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const ProfileState()]));

    when(globalCubit.state).thenReturn(GlobalInitial());
    when(globalCubit.stream).thenAnswer((_) => Stream.value(GlobalInitial()));
    when(globalCubit.isArLanguage).thenReturn(false);
  });

  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<GlobalCubit>.value(value: globalCubit),
              BlocProvider<ProfileCubit>.value(
                value: cubit
                  ..doIntent(
                    ProfileInitializationIntent(globalCubit: globalCubit),
                  ),
              ),
            ],
            child: const Scaffold(body: ProfileView()),
          ),
        );
      },
    );
  }

  testWidgets("Verify profile Initial State UI", (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey(WidgetKeys.profileAppBar)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.notification)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.userCard)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.photo)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.name)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.email)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.phone)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.arrowRight)), findsNWidgets(2));
    expect(find.byKey(const ValueKey(WidgetKeys.vehicleCard)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.vehicleInfo)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.vehicleType)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.vehicleNumber)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.langItem)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.logoutText)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.logout)), findsNWidgets(2));

  });
  testWidgets("Verify bottom sheet opens when tapping language item", (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final langItemFinder = find.byKey(const ValueKey(WidgetKeys.langItem));
    expect(langItemFinder, findsOneWidget);
    await tester.tap(langItemFinder);
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey(WidgetKeys.changeLanguage)),findsOneWidget,);
    expect(find.byKey(const ValueKey(WidgetKeys.radioItemEn)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.radioItemAr)), findsOneWidget);
    expect(find.byKey(const ValueKey(WidgetKeys.bottomSheetSelectionItem)), findsOneWidget,
    );
  });
}
