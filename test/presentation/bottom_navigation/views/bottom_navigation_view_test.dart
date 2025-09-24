import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_cubit.dart';
import 'package:mockito/mockito.dart';

import 'bottom_navigation_view_test.mocks.dart';

@GenerateMocks([BottomNavigationCubit])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockBottomNavigationCubit cubit;

  setUp(() {
    cubit = MockBottomNavigationCubit();
  });

  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<BottomNavigationCubit>.value(
            value: cubit,
            child: const BottomNavigationView(),
          ),
        );
      },
    );
  }

  testWidgets('BottomNavigationBar icons test', (WidgetTester tester) async {
    when(cubit.state).thenReturn(const BottomNavigationState(currentIndex: 0));
    when(cubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('bottom_nav_bar')), findsOneWidget);

    expect(find.byKey(const ValueKey('bottom_nav_icon_0')), findsOneWidget);
    expect(find.byKey(const ValueKey('bottom_nav_icon_1')), findsOneWidget);
    expect(find.byKey(const ValueKey('bottom_nav_icon_2')), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(4));

    await tester.tap(find.byKey(const ValueKey('bottom_nav_icon_0')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('bottom_nav_icon_1')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('bottom_nav_icon_2')));
    await tester.pumpAndSettle();
  });

  testWidgets('tapping on items changes currentIndex', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('bottom_nav_icon_1')));
    await tester.pumpAndSettle();

    final bottomNavBar = tester.widget<BottomNavigationBar>(
      find.byKey(const ValueKey('bottom_nav_bar')),
    );

    expect(bottomNavBar.currentIndex, 1);
  });
  testWidgets('swiping PageView right-to-left changes tab to Orders', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();

    final bottomNavBar = tester.widget<BottomNavigationBar>(
      find.byKey(const ValueKey('bottom_nav_bar')),
    );

    expect(bottomNavBar.currentIndex, 1);
  });


  testWidgets('swiping left-to-right from Orders moves back to Home', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('bottom_nav_icon_1')));
    await tester.pumpAndSettle();


    await tester.fling(find.byType(PageView), const Offset(400, 0), 1000);
    await tester.pumpAndSettle();

    final bottomNavBar = tester.widget<BottomNavigationBar>(
      find.byKey(const ValueKey('bottom_nav_bar')),
    );

    expect(bottomNavBar.currentIndex, 0);
  });

 }
