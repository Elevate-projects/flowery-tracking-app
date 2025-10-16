import 'package:flowery_tracking_app/presentation/home/views/widgets/shimmer/address_item_shimmer.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/shimmer/recent_item_shimmer.dart';
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
        return const MaterialApp(home: Scaffold(body: RecentItemShimmer()));
      },
    );
  }

  testWidgets("Verifying RecentItemShimmer Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.margin is REdgeInsets &&
            widget.padding is REdgeInsets &&
            widget.child is Column,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.length == 10 &&
            widget.children.first is ShimmerEffect,
      ),
      findsOneWidget,
    );
    expect(find.byType(ShimmerEffect), findsNWidgets(11));
    expect(find.byType(RPadding), findsNWidgets(1));
    expect(find.byType(Row), findsNWidgets(3));
    expect(find.byType(Expanded), findsNWidgets(4));
    expect(find.byType(AddressItemShimmer), findsNWidgets(2));
    expect(find.byType(RSizedBox), findsNWidgets(9));
  });
}
