import 'package:flowery_tracking_app/presentation/home/views/widgets/shimmer/address_item_shimmer.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/shimmer/order_item_shimmer.dart';
import 'package:flowery_tracking_app/utils/common_widgets/shimmer_effect.dart';
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
        return const MaterialApp(home: OrderItemShimmer());
      },
    );
  }

  testWidgets("Verifying OrderItemShimmer Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.child is Column &&
            widget.padding is REdgeInsets &&
            widget.margin is REdgeInsets,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.length == 11,
      ),
      findsOneWidget,
    );
    expect(find.byType(ShimmerEffect), findsNWidgets(12));
    expect(find.byType(RSizedBox), findsNWidgets(11));
    expect(find.byType(Expanded), findsNWidgets(4));
    expect(find.byType(AddressItemShimmer), findsNWidgets(2));
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Row &&
            widget.children.length == 5 &&
            widget.children.first is ShimmerEffect,
      ),
      findsNWidgets(1),
    );
  });
}
