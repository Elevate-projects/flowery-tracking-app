import 'package:flowery_tracking_app/presentation/onboarding/views/widgets/onboarding_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('testing the on_boarding widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => const MaterialApp(
          home: Scaffold(
            body: OnboardingViewBody(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(OnboardingViewBody), findsOneWidget);
  });
}