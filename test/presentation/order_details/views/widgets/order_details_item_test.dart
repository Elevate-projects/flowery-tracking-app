import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/domain/entities/product/product_entity.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_item.dart';
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
            body: OrderDetailsItem(
              orderData: OrderItemEntity(
                id: "123",
                product: ProductEntity(
                  id: "123",
                  title: "title",
                  imgCover: "image",
                ),
                quantity: 5,
                price: 123,
              ),
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OrderDetailsItem Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.child is Row &&
            widget.padding is REdgeInsets,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Row && widget.children.first is CircleAvatar,
      ),
      findsOneWidget,
    );
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(RSizedBox), findsNWidgets(2));
    expect(find.byType(Expanded), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.first is Text,
      ),
      findsOneWidget,
    );
    expect(find.byType(Text), findsNWidgets(3));
    expect(find.byType(Flexible), findsNWidgets(1));
    expect(find.byType(Row), findsNWidgets(2));
  });
}
