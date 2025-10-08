import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_payment_details_section.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_custom_container.dart';
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
                CompletedOrderPaymentDetailsSection(
                  orderData: OrderEntity(id: "order_1"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying CompletedOrderPaymentDetailsSection Widgets", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(SliverPadding), findsOneWidget);
    expect(find.byType(SliverToBoxAdapter), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(OrderDetailsCustomContainer), findsNWidgets(2));
    expect(find.byType(RSizedBox), findsNWidgets(3));
  });
}
