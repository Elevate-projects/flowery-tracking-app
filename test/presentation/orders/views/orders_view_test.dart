import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/orders/views/orders_view.dart';
import 'package:flowery_tracking_app/presentation/orders/views/widgets/orders_view_body.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_cubit.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_intent.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_view_test.mocks.dart';

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
            child: const OrdersView(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OrdersView Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(OrdersViewBody), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
