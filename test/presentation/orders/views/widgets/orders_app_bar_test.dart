import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/orders_app_bar.dart';
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
        return const MaterialApp(home: Scaffold(body: OrdersAppBar()));
      },
    );
  }

  testWidgets("Verifying OrdersAppBar Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(RPadding), findsOneWidget);
    expect(find.byType(FittedBox), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.text(AppText.myOrders.tr()), findsOneWidget);
  });
}
