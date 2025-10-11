import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/success_screen.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestWidget() {
    return MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) => const Scaffold(body: SuccessScreen()),
      ),
    );
  }

  testWidgets('renders all UI elements correctly', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(Image), findsOneWidget);
    expect(find.text(AppText.thankYou), findsOneWidget);
    expect(find.text(AppText.theOrderDelivered), findsOneWidget);
    expect(
      find.widgetWithText(CustomElevatedButton, AppText.done),
      findsOneWidget,
    );
  });

  testWidgets('navigates to bottom navigation when Done is pressed', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, _) => const Scaffold(body: SuccessScreen()),
        ),
        routes: {
          RouteNames.bottomNavigation: (_) =>
              const Scaffold(body: Text('Bottom Nav')),
        },
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(CustomElevatedButton, AppText.done));
    await tester.pumpAndSettle();

    expect(find.text('Bottom Nav'), findsOneWidget);
  });
}
