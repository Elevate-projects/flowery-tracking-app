import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/order_status.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/order_status_item.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_cubit.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_intent.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_status_test.mocks.dart';

@GenerateMocks([OrdersCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockOrdersCubit mockOrdersCubit;
  setUp(() {
    mockOrdersCubit = MockOrdersCubit();
    getIt.registerFactory<OrdersCubit>(() => mockOrdersCubit);
    provideDummy<OrdersState>(const OrdersState());
    when(mockOrdersCubit.state).thenReturn(const OrdersState());
    when(
      mockOrdersCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const OrdersState()]));
  });
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<OrdersCubit>.value(
            value: mockOrdersCubit
              ..doIntent(intent: const OrdersInitializationIntent()),
            child: const OrderStatus(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OrderStatus Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocBuilder<OrdersCubit, OrdersState>), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Row &&
            widget.children.length == 3 &&
            widget.children.first is Expanded,
      ),
      findsOneWidget,
    );
    expect(find.byType(Expanded), findsNWidgets(2));
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RSizedBox && widget.width == 33,
      ),
      findsNWidgets(1),
    );
    expect(find.byType(OrderStatusItem), findsNWidgets(2));
  });

  tearDown(() {
    getIt.reset();
  });
}
