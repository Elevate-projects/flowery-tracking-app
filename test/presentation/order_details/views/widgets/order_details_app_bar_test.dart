import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_app_bar.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_intent.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'order_details_addresses_test.mocks.dart';

@GenerateMocks([OrderDetailsCubit])
void main() {
  // Arrange
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
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<OrderDetailsCubit>.value(
            value: mockOrderDetailsCubit
              ..doIntent(intent: const OrderDetailsInitializationIntent()),
            child: const Scaffold(
              body: CustomScrollView(slivers: [OrderDetailsAppBar()]),
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OrderDetailsAppBar Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(SliverAppBar), findsOneWidget);
    expect(find.byType(FlexibleSpaceBar), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.length == 3 &&
            widget.children.first is Flexible,
      ),
      findsOneWidget,
    );
    expect(find.byType(Flexible), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Padding &&
            widget.padding is REdgeInsetsDirectional &&
            widget.child is FittedBox,
      ),
      findsOneWidget,
    );
    expect(find.byType(FittedBox), findsOneWidget);
    expect(find.text(AppText.orderDetails.tr()), findsOneWidget);
    expect(find.byType(RSizedBox), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RPadding && widget.child is StepProgressIndicator,
      ),
      findsOneWidget,
    );
  });
}
