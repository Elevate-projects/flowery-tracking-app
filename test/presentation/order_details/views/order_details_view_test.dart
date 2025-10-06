import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/order_details_view.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_nav_bar.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_view_body.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/shimmer/order_details_nav_bar_shimmer.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/shimmer/order_details_view_body_shimmer.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_intent.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_details_view_test.mocks.dart';

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
            child: const Scaffold(body: OrderDetailsView()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OrderDetailsView Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(OrderDetailsNavBar), findsOneWidget);
    expect(find.byType(OrderDetailsViewBody), findsOneWidget);
  });

  testWidgets("Verifying OrderDetailsView On Loading State Widgets", (
    tester,
  ) async {
    //Arrange
    when(
      mockOrderDetailsCubit.state,
    ).thenReturn(const OrderDetailsState(orderStatus: StateStatus.loading()));
    when(mockOrderDetailsCubit.stream).thenAnswer(
      (_) => Stream.value(
        const OrderDetailsState(orderStatus: StateStatus.loading()),
      ),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(OrderDetailsNavBarShimmer), findsOneWidget);
    expect(find.byType(OrderDetailsViewBodyShimmer), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
