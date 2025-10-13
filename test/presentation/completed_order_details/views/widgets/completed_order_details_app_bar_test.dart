import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/widgets/completed_order_details_app_bar.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_back_arrow.dart';
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
            body: CustomScrollView(slivers: [CompletedOrderDetailsAppBar()]),
          ),
        );
      },
    );
  }

  testWidgets("Verifying CompletedOrderDetailsAppBar Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(SliverAppBar), findsOneWidget);
    expect(find.byType(FlexibleSpaceBar), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.length == 1 &&
            widget.children.first is Flexible,
      ),
      findsOneWidget,
    );
    expect(find.byType(Flexible), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Padding &&
            widget.padding is REdgeInsetsDirectional &&
            widget.child is Row,
      ),
      findsOneWidget,
    );
    expect(find.byType(FittedBox), findsOneWidget);
    expect(find.byType(CustomBackArrow), findsOneWidget);
    expect(find.text(AppText.orderDetails.tr()), findsOneWidget);
  });
}
