import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_address.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_addresses.dart';
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
            body: CompletedOrderDetailsAddresses(orderData: OrderEntity()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying CompletedOrderDetailsAddresses Widgets", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && widget.data == AppText.pickupAddress.tr(),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RSizedBox && widget.height == 16,
      ),
      findsNWidgets(3),
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && widget.data == AppText.userAddress.tr(),
      ),
      findsOneWidget,
    );
    expect(find.byType(CompletedOrderDetailsAddress), findsNWidgets(2));
  });
}
