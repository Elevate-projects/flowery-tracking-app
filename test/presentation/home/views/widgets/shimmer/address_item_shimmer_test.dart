import 'package:flowery_tracking_app/presentation/home/views/widgets/shimmer/address_item_shimmer.dart';
import 'package:flowery_tracking_app/utils/common_widgets/shimmer_effect.dart';
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
        return const MaterialApp(home: AddressItemShimmer());
      },
    );
  }

  testWidgets("Verifying AddressItemShimmer Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Container && widget.child is Row,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Row &&
            widget.crossAxisAlignment == CrossAxisAlignment.center &&
            widget.children.length == 3,
      ),
      findsOneWidget,
    );
    expect(find.byType(ShimmerEffect), findsNWidgets(3));
    expect(find.byType(RSizedBox), findsNWidgets(2));
    expect(find.byType(Expanded), findsNWidgets(1));
    expect(find.byType(Column), findsNWidgets(1));
  });
}
