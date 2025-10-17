import 'package:flowery_tracking_app/presentation/edit_vechile/widget/custom_arrow_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
class MockCallback extends Mock {
  void call(String value);
}

void main() {
  testWidgets('CustomArrowDown shows bottom sheet and calls onSelect', (WidgetTester tester) async {
    final mockCallback = MockCallback();

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            home: Scaffold(
              body: CustomArrowDown(onSelect: mockCallback.call),
            ),
          );
        },
      ),
    );

    // Assert arrow icon exists
    expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);

    // Act: Tap on the arrow to show bottom sheet
    await tester.tap(find.byType(CustomArrowDown));
    await tester.pumpAndSettle();

    // Assert: Bottom sheet is displayed
    expect(find.byType(ListView), findsOneWidget);

    // Act: Tap on an item
    await tester.tap(find.text('Sedan'));
    await tester.pumpAndSettle();

    // Assert: onSelect is called with correct value
    verify(mockCallback('Sedan')).called(1);
  });
}
