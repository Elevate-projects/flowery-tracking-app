import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_addresses.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_app_bar.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_list.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_view_body.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_information.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_payment_details_section.dart';
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
            body: CompletedOrderDetailsViewBody(
              orderData: OrderEntity(
                id: "order_1",
                orderItems: [OrderItemEntity(id: "item_1")],
              ),
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying CompletedOrderDetailsViewBody Widgets", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.byType(CompletedOrderDetailsAppBar), findsOneWidget);
    expect(find.byType(SliverPadding), findsNWidgets(3));
    expect(find.byType(SliverToBoxAdapter), findsNWidgets(2));
    expect(find.byType(CompletedOrderInformation), findsOneWidget);
    expect(find.byType(CompletedOrderDetailsAddresses), findsOneWidget);
    expect(find.byType(Visibility), findsNWidgets(2));
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && widget.data == AppText.orderDetails.tr(),
      ),
      findsNWidgets(2),
    );
    expect(find.byType(CompletedOrderDetailsList), findsOneWidget);
    expect(find.byType(CompletedOrderPaymentDetailsSection), findsOneWidget);
  });
}
