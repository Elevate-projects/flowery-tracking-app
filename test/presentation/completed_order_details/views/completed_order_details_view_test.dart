import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/completed_order_details_view.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_view_body.dart';
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
          home: CompletedOrderDetailsView(
            orderData: OrderEntity(
              id: "order_1",
              orderItems: [OrderItemEntity(id: "item_1")],
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying CompletedOrderDetailsView Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(CompletedOrderDetailsViewBody), findsOneWidget);
  });
}
