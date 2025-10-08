import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/address_item.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/recent_order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(
          home: Scaffold(body: RecentOrderItem(orderData: OrderEntity())),
        );
      },
    );
  }

  testWidgets("Verifying RecentOrderItem Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(InkWell), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.padding is REdgeInsets &&
            widget.child is Column,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.children.first is FittedBox &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.length == 10,
      ),
      findsOneWidget,
    );
    expect(find.byType(FittedBox), findsNWidgets(10));
    expect(find.byType(Text), findsNWidgets(9));
    expect(find.byType(SvgPicture), findsNWidgets(3));
    expect(find.byType(RPadding), findsNWidgets(1));
    expect(find.byType(AddressItem), findsNWidgets(2));
    expect(find.byType(Expanded), findsNWidgets(4));
  });
}
