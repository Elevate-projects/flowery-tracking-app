import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_address.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_intent.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_details_address_test.mocks.dart';

@GenerateMocks([OrderDetailsCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockOrderDetailsCubit mockOrderDetailsCubit;
  setUp(() {
    mockOrderDetailsCubit = MockOrderDetailsCubit();
    getIt.registerFactory<OrderDetailsCubit>(() => mockOrderDetailsCubit);
    provideDummy<OrderDetailsState>(const OrderDetailsState());
    when(mockOrderDetailsCubit.state).thenReturn(const OrderDetailsState());
    when(
      mockOrderDetailsCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const OrderDetailsState()]));
  });
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<OrderDetailsCubit>.value(
            value: mockOrderDetailsCubit
              ..doIntent(intent: const OrderDetailsInitializationIntent()),
            child: const Scaffold(
              body: OrderDetailsAddress(
                title: 'title',
                image: 'image',
                address: 'address',
                phone: 'phone',
              ),
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OrderDetailsAddress Widgets", (tester) async {
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
    expect(find.byType(RSizedBox), findsNWidgets(5));
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RSizedBox && widget.width == 8,
      ),
      findsNWidgets(2),
    );
    expect(find.byType(Expanded), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.first is Text,
      ),
      findsOneWidget,
    );
    expect(find.byType(Row), findsNWidgets(3));
    expect(find.byType(InkWell), findsNWidgets(3));
    expect(find.byType(SvgPicture), findsNWidgets(3));
    expect(find.byType(Flexible), findsNWidgets(1));
    expect(find.byType(Text), findsNWidgets(2));
  });

  testWidgets(
    "Verifying OrderDetailsAddress Widgets On Phone Icon Loading State",
    (tester) async {
      //Arrange
      when(mockOrderDetailsCubit.state).thenReturn(
        const OrderDetailsState(
          openPhoneStatus: StateStatus.loading(),
          isOpeningPhone: true,
          selectedPhoneNumber: "phone",
        ),
      );
      when(mockOrderDetailsCubit.stream).thenAnswer(
        (_) => Stream.value(
          const OrderDetailsState(
            openPhoneStatus: StateStatus.loading(),
            isOpeningPhone: true,
            selectedPhoneNumber: "phone",
          ),
        ),
      );
      // Act
      await tester.pumpWidget(prepareWidget());
      // Assert
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is LoadingCircle &&
              widget.height == 14.r &&
              widget.width == 14.r,
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    "Verifying OrderDetailsAddress Widgets On Whatsapp Icon Loading State",
    (tester) async {
      //Arrange
      when(mockOrderDetailsCubit.state).thenReturn(
        const OrderDetailsState(
          openWhatsappStatus: StateStatus.loading(),
          isOpeningWhatsapp: true,
          selectedPhoneNumber: "phone",
        ),
      );
      when(mockOrderDetailsCubit.stream).thenAnswer(
        (_) => Stream.value(
          const OrderDetailsState(
            openWhatsappStatus: StateStatus.loading(),
            isOpeningWhatsapp: true,
            selectedPhoneNumber: "phone",
          ),
        ),
      );
      // Act
      await tester.pumpWidget(prepareWidget());
      // Assert
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is LoadingCircle &&
              widget.height == 14.r &&
              widget.width == 14.r,
        ),
        findsOneWidget,
      );
    },
  );

  tearDown(() {
    getIt.reset();
  });
}
