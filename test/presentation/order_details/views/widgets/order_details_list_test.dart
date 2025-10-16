import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_item.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_list.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_intent.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_details_addresses_test.mocks.dart';

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
              body: CustomScrollView(slivers: [OrderDetailsList()]),
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OrderDetailsList Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(SliverPadding), findsOneWidget);
    expect(find.byType(SliverList), findsOneWidget);
    expect(find.byType(OrderDetailsItem), findsNWidgets(8));
  });
}
