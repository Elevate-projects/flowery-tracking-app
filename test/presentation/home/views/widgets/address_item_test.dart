import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/address_item.dart';
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
          home: AddressItem(
            title: "Address Title",
            image: "Address Image",
            address: "Address Data",
          ),
        );
      },
    );
  }

  testWidgets("Verifying Address Item Widget", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.child is Row &&
            widget.padding is REdgeInsets,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Row && widget.children.first is CircleAvatar,
      ),
      findsOneWidget,
    );
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(RSizedBox), findsNWidgets(3));
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RSizedBox && widget.width == 8,
      ),
      findsOneWidget,
    );
    expect(find.byType(Expanded), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.first is FittedBox,
      ),
      findsOneWidget,
    );
    expect(find.byType(Row), findsNWidgets(2));
    expect(find.byType(SvgPicture), findsNWidgets(1));
    expect(find.byType(Flexible), findsNWidgets(1));
    expect(find.byType(Text), findsNWidgets(2));
  });
}
