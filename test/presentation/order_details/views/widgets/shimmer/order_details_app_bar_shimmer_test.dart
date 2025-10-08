import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/shimmer/order_details_app_bar_shimmer.dart';
import 'package:flowery_tracking_app/utils/common_widgets/shimmer_effect.dart';
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
          home: CustomScrollView(slivers: [OrderDetailsAppBarShimmer()]),
        );
      },
    );
  }

  testWidgets("Verifying OrderDetailsAppBarShimmer Widgets", (tester) async {
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
            widget.children.length == 3 &&
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
            widget.child is FittedBox,
      ),
      findsOneWidget,
    );
    expect(find.byType(FittedBox), findsOneWidget);
    expect(find.text(AppText.orderDetails.tr()), findsOneWidget);
    expect(find.byType(RSizedBox), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RPadding && widget.child is Row,
      ),
      findsOneWidget,
    );
    expect(find.byType(Expanded), findsNWidgets(5));
    expect(find.byType(ShimmerEffect), findsNWidgets(5));
  });
}
