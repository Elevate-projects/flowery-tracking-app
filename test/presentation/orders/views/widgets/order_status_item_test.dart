import 'package:flowery_tracking_app/presentation/orders/views/widgets/order_status_item.dart';
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
          home: Scaffold(
            body: OrderStatusItem(
              ordersNumber: 'ordersNumber',
              orderStatus: 'orderStatus',
              statusIcon: 'statusIcon',
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OrderStatusItem Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(FittedBox), findsNWidgets(2));
    expect(find.byType(RSizedBox), findsNWidgets(2));
    expect(find.byType(Row), findsNWidgets(1));
    expect(find.byType(SvgPicture), findsNWidgets(1));
    expect(find.byType(Flexible), findsNWidgets(1));
    expect(find.byType(Text), findsNWidgets(2));
  });
}
