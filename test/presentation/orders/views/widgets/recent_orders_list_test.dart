import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/recent_orders_list.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_cubit.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_intent.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recent_orders_list_test.mocks.dart';

@GenerateMocks([OrdersCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockOrdersCubit mockOrdersCubit;
  setUp(() {
    mockOrdersCubit = MockOrdersCubit();
    getIt.registerFactory<OrdersCubit>(() => mockOrdersCubit);
    provideDummy<OrdersState>(const OrdersState());
    when(mockOrdersCubit.state).thenReturn(
      const OrdersState(
        driverOrdersStatus: StateStatus.success([
          OrderEntity(id: "order_1"),
          OrderEntity(id: "order_2"),
        ]),
      ),
    );
    when(mockOrdersCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const OrdersState(
          driverOrdersStatus: StateStatus.success([
            OrderEntity(id: "order_1"),
            OrderEntity(id: "order_2"),
          ]),
        ),
      ]),
    );
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
            child: const Scaffold(body: RecentOrdersList()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying RecentOrdersList Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.first is RPadding,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RPadding && widget.child is FittedBox,
      ),
      findsOneWidget,
    );
    expect(find.text(AppText.recentOrders.tr()), findsOneWidget);
    expect(find.byType(BlocBuilder<OrdersCubit, OrdersState>), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Expanded && widget.child is ListView,
      ),
      findsOneWidget,
    );
  });

  tearDown(() {
    getIt.reset();
  });
}
