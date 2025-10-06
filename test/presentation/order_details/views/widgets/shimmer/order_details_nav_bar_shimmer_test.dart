import 'package:flowery_tracking_app/presentation/order_details/views/widgets/shimmer/order_details_nav_bar_shimmer.dart';
import 'package:flowery_tracking_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: OrderDetailsNavBarShimmer());
      },
    );
  }

  testWidgets("Verifying OrderDetailsNavBarShimmer Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.child is ShimmerEffect &&
            widget.padding is REdgeInsets,
      ),
      findsOneWidget,
    );
    expect(find.byType(ShimmerEffect), findsOneWidget);
  });
}
