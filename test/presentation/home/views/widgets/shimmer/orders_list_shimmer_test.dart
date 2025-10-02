import 'package:flowery_tracking_app/presentation/home/views/widgets/shimmer/orders_list_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: OrdersListShimmer());
      },
    );
  }

  testWidgets("Verifying OrdersListShimmer Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is ListView &&
            widget.padding is REdgeInsets &&
            widget.physics is BouncingScrollPhysics,
      ),
      findsOneWidget,
    );
  });
}
