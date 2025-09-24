import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_cubit.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_state.dart';
import 'bottom_navigation_view_test.mocks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@GenerateMocks([BottomNavigationCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockBottomNavigationCubit cubit;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    cubit = MockBottomNavigationCubit();

    when(cubit.state).thenReturn(const BottomNavigationState(currentIndex: 0));
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    when(cubit.pageController).thenReturn(PageController());
    when(cubit.pages).thenReturn(const [
      Center(child: Text("Home")),
      Center(child: Text("Orders")),
      Center(child: Text("Profile")),
    ]);

    when(cubit.doIntent(any)).thenReturn(null);
  });

  Widget prepareWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            home: BlocProvider<BottomNavigationCubit>.value(
              value: cubit,
              child: const BottomNavigationView(),
            ),
          );
        },
      ),
    );
  }

  testWidgets('Initial UI shows Home tab', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text("Home"), findsOneWidget);
    expect(find.text("Orders"), findsNothing);
    expect(find.text("Profile"), findsNothing);
  });

  testWidgets('Tap on Home tab updates Cubit', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('tab_0')));
    await tester.pumpAndSettle();

    verify(cubit.doIntent(argThat(isA<OnBottomTabsClick>().having((i) => i.index, 'index', 0)))).called(1);
  });

  testWidgets('Tap on Orders tab updates Cubit', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('tab_1')));
    await tester.pumpAndSettle();

    verify(cubit.doIntent(argThat(isA<OnBottomTabsClick>().having((i) => i.index, 'index', 1)))).called(1);
  });

  testWidgets('Tap on Profile tab updates Cubit', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('tab_2')));
    await tester.pumpAndSettle();

    verify(cubit.doIntent(argThat(isA<OnBottomTabsClick>().having((i) => i.index, 'index', 2)))).called(1);
  });

  testWidgets('Swipe PageView updates Cubit', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final pageView = find.byType(PageView);
    expect(pageView, findsOneWidget);

    // Swipe left (Home → Orders)
    await tester.drag(pageView, const Offset(-400, 0));
    await tester.pumpAndSettle();
    verify(cubit.doIntent(argThat(isA<OnPageSwiped>().having((i) => i.index, 'index', 1)))).called(1);

    // Swipe left again (Orders → Profile)
    await tester.drag(pageView, const Offset(-400, 0));
    await tester.pumpAndSettle();
    verify(cubit.doIntent(argThat(isA<OnPageSwiped>().having((i) => i.index, 'index', 2)))).called(1);

    // Swipe right (Profile → Orders)
    await tester.drag(pageView, const Offset(400, 0));
    await tester.pumpAndSettle();
    verify(cubit.doIntent(argThat(isA<OnPageSwiped>().having((i) => i.index, 'index', 1)))).called(1);
  });
}
