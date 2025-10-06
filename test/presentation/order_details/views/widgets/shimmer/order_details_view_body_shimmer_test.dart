import 'package:flowery_tracking_app/presentation/order_details/views/widgets/shimmer/order_details_app_bar_shimmer.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/shimmer/order_details_view_body_shimmer.dart';
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
        return const MaterialApp(home: OrderDetailsViewBodyShimmer());
      },
    );
  }

  testWidgets("Verifying OrderDetailsViewBodyShimmer Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.byType(OrderDetailsAppBarShimmer), findsOneWidget);
    expect(find.byType(SliverPadding), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(4));
    expect(find.byType(ShimmerEffect), findsNWidgets(13));
  });
}
