import 'package:flowery_tracking_app/presentation/onboarding/views/widgets/appley_button.dart' show AppleyButtonWidget;
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() {
  testWidgets('testing the appley_button widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => const MaterialApp(
          home: Scaffold(
            body: AppleyButtonWidget(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CustomElevatedButton), findsOneWidget);
  });
}
