import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_address.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_addresses.dart';
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
            child: const Scaffold(body: OrderDetailsAddresses()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OrderDetailsAddresses Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && widget.data == AppText.pickupAddress.tr(),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RSizedBox && widget.height == 16,
      ),
      findsNWidgets(3),
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && widget.data == AppText.userAddress.tr(),
      ),
      findsOneWidget,
    );
    expect(find.byType(OrderDetailsAddress), findsNWidgets(2));
  });
}
