import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/orders_app_bar.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/shimmer/order_view_body_shimmer.dart';
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
        return const MaterialApp(home: Scaffold(body: OrderViewBodyShimmer()));
      },
    );
  }

  testWidgets("Verifying OrderViewBodyShimmer Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.length == 6 &&
            widget.children.first is RSizedBox,
      ),
      findsOneWidget,
    );
    expect(find.byType(OrdersAppBar), findsOneWidget);
    expect(find.byType(Expanded), findsNWidgets(12));
    expect(find.byType(Row), findsNWidgets(7));
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.text(AppText.recentOrders.tr()), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Expanded && widget.child is ListView,
      ),
      findsOneWidget,
    );
  });
}
