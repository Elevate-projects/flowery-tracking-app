import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_list.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_item.dart';
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
        return const MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                CompletedOrderDetailsList(
                  orderItems: [
                    OrderItemEntity(id: "order_1"),
                    OrderItemEntity(id: "order_2"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying CompletedOrderDetailsList Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Visibility), findsOneWidget);
    expect(find.byType(SliverPadding), findsOneWidget);
    expect(find.byType(SliverList), findsOneWidget);
    expect(find.byType(OrderDetailsItem), findsNWidgets(2));
  });
}
