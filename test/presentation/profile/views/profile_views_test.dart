import 'package:flowery_tracking_app/core/constants/const_keys.dart';
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

    expect(find.byKey(const ValueKey(ConstKeys.profileAppBar)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.notification)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.userCard)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.photo)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.name)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.email)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.phone)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.arrowRight)), findsNWidgets(2));
    expect(find.byKey(const ValueKey(ConstKeys.vehicleCard)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.vehicleInfo)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.vehicleType)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.vehicleNumber)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.langItem)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.logoutText)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.logout)), findsNWidgets(2));

  });
  testWidgets("Verify bottom sheet opens when tapping language item", (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final langItemFinder = find.byKey(const ValueKey(ConstKeys.langItem));
    expect(langItemFinder, findsOneWidget);
    await tester.tap(langItemFinder);
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey(ConstKeys.changeLanguage)),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey(ConstKeys.radioItemEn)), findsOneWidget);
    expect(find.byKey(const ValueKey(ConstKeys.radioItemAr)), findsOneWidget);
    expect(
      find.byKey(const ValueKey(ConstKeys.bottomSheetSelectionItem)),
      findsOneWidget,
    );
  });
}
