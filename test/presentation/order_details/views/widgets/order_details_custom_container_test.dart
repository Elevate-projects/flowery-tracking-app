import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(
          home: Scaffold(
            body: OrderDetailsCustomContainer(
              title: "title",
              suffixTitle: "suffixTitle",
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OrderDetailsCustomContainer Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Container && widget.child is Row,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Row &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.length == 2 &&
            widget.children.first is Expanded,
      ),
      findsOneWidget,
    );
    expect(find.byType(Expanded), findsNWidgets(1));
    expect(find.byType(Text), findsNWidgets(2));
  });
}
