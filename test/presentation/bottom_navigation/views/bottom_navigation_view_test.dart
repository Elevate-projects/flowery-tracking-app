import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flowery_tracking_app/core/constants/widget_keys.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_cubit.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bottom_navigation_view_test.mocks.dart';

@GenerateMocks([BottomNavigationCubit])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockBottomNavigationCubit cubit;

  setUpAll(() {
    getIt.registerFactory<BottomNavigationCubit>(() => cubit);
  });
  setUp(() {
    cubit = MockBottomNavigationCubit();
    provideDummy<BottomNavigationState>(const BottomNavigationState());
    when(cubit.state).thenReturn(const BottomNavigationState());
    when(
      cubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const BottomNavigationState()]));
    when(cubit.pages).thenReturn(const [
      Center(child: Text("Home")),
      Center(child: Text("Orders")),
      Center(child: Text("Profile")),
    ]);
    when(cubit.pageController).thenReturn(PageController());
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
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey(WidgetKeys.bottomNavBarKey)),
      findsOneWidget,
    );

    expect(find.byKey(const ValueKey('bottom_nav_icon_0')), findsOneWidget);
    expect(find.byKey(const ValueKey('bottom_nav_icon_1')), findsOneWidget);
    expect(find.byKey(const ValueKey('bottom_nav_icon_2')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('bottom_nav_icon_0')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('bottom_nav_icon_1')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('bottom_nav_icon_2')));
    await tester.pumpAndSettle();
  });

  testWidgets('tapping on tab changes icon color', (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final iconFinder = find.byKey(const ValueKey('bottom_nav_icon_0'));

    await tester.tap(iconFinder);
    await tester.pumpAndSettle();

    final iconWrapper = tester.widget<RPadding>(iconFinder);
    final iconAfter = iconWrapper.child as SvgPicture;

    final BuildContext context = tester.element(iconFinder);
    final expectedColor = Theme.of(context).colorScheme.primary;
    final expectedFilter = ColorFilter.mode(expectedColor, BlendMode.srcIn);

    expect(iconAfter.colorFilter, equals(expectedFilter));

    final secondIconFinder = find.byKey(const ValueKey('bottom_nav_icon_1'));
    final secondWrapper = tester.widget<RPadding>(secondIconFinder);
    final secondIcon = secondWrapper.child as SvgPicture;

    final expectedUnselectedFilter = ColorFilter.mode(
      AppColors.white[80]!,
      BlendMode.srcIn,
    );
    expect(secondIcon.colorFilter, equals(expectedUnselectedFilter));

    final thirdIconFinder = find.byKey(const ValueKey('bottom_nav_icon_2'));
    final thirdWrapper = tester.widget<RPadding>(thirdIconFinder);
    final thirdIcon = thirdWrapper.child as SvgPicture;

    expect(thirdIcon.colorFilter, equals(expectedUnselectedFilter));
  });
}
