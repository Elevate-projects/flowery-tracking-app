import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(
          home: CompletedOrderInformation(
            orderData: OrderEntity(
              id: "order_1",
              orderItems: [OrderItemEntity(id: "item_1")],
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying CompletedOrderInformation Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(RPadding), findsOneWidget);
    expect(find.byType(Row), findsNWidgets(2));
    expect(find.byType(Expanded), findsNWidgets(2));
    expect(find.byType(SvgPicture), findsNWidgets(1));
    expect(find.byType(Flexible), findsNWidgets(1));
    expect(find.byType(FittedBox), findsNWidgets(3));
    expect(find.byType(Text), findsNWidgets(2));
  });
}
