import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/orders_list.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/shimmer/orders_list_shimmer.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_cubit.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_intent.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_list_test.mocks.dart';

@GenerateMocks([HomeCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockHomeCubit mockHomeCubit;
  setUp(() {
    mockHomeCubit = MockHomeCubit();
    getIt.registerFactory<HomeCubit>(() => mockHomeCubit);
    provideDummy<HomeState>(const HomeState());
    when(mockHomeCubit.state).thenReturn(const HomeState());
    when(
      mockHomeCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HomeState()]));
  });
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<HomeCubit>.value(
            value: mockHomeCubit
              ..doIntent(intent: const HomeInitializationIntent()),
            child: const OrdersList(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OrdersList Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocBuilder<HomeCubit, HomeState>), findsOneWidget);
    expect(find.byType(OrdersListShimmer), findsOneWidget);
  });

  testWidgets(
    "Verifying OrdersList Widgets shows List Of Data On Success state",
    (tester) async {
      // Arrange
      when(mockHomeCubit.state).thenReturn(
        const HomeState(
          pendingOrdersStatus: StateStatus.success([
            OrderEntity(id: "1"),
            OrderEntity(id: "2"),
          ]),
          isReloading: false,
        ),
      );
      when(mockHomeCubit.stream).thenAnswer(
        (_) => Stream.value(
          const HomeState(
            pendingOrdersStatus: StateStatus.success([
              OrderEntity(id: "1"),
              OrderEntity(id: "2"),
            ]),
            isReloading: false,
          ),
        ),
      );

      // Act
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      // Assert
      expect(find.byType(RefreshIndicator), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    },
  );
  testWidgets(
    "Verifying OrdersList Widgets shows empty data On Success state",
    (tester) async {
      // Arrange
      when(mockHomeCubit.state).thenReturn(
        const HomeState(
          pendingOrdersStatus: StateStatus.success([]),
          isReloading: false,
        ),
      );
      when(mockHomeCubit.stream).thenAnswer(
        (_) => Stream.value(
          const HomeState(
            pendingOrdersStatus: StateStatus.success([]),
            isReloading: false,
          ),
        ),
      );

      // Act
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      // Assert
      expect(find.byType(AnimationLoaderWidget), findsOneWidget);
      expect(find.text(AppText.emptyOrdersMessage.tr()), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is RPadding && widget.child is CustomElevatedButton,
        ),
        findsOneWidget,
      );
      expect(find.text(AppText.reload.tr()), findsOneWidget);
    },
  );

  tearDown(() {
    getIt.reset();
  });
}
