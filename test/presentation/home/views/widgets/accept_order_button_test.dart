import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/accept_order_button.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_cubit.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_intent.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/loading_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_view_body_test.mocks.dart';

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
  Widget prepareWidget({required OrderEntity order}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<HomeCubit>.value(
            value: mockHomeCubit
              ..doIntent(intent: const HomeInitializationIntent()),
            child: AcceptOrderButton(orderData: order),
          ),
        );
      },
    );
  }

  testWidgets("Verifying AcceptOrderButton Widget", (tester) async {
    // Act
    await tester.pumpWidget(
      prepareWidget(order: const OrderEntity(id: "order-1")),
    );
    // Assert
    expect(find.byType(BlocBuilder<HomeCubit, HomeState>), findsOneWidget);
    expect(find.byType(CustomElevatedButton), findsOneWidget);
    expect(find.text(AppText.accept.tr()), findsOneWidget);
  });

  testWidgets(
    "Verifying AcceptOrderButton Widget shows LoadingButton when loading state",
    (tester) async {
      // Arrange
      final order = const OrderEntity(id: "test-order-id");

      when(mockHomeCubit.state).thenReturn(
        const HomeState(
          acceptOrderStatus: StateStatus.loading(),
          currentOrderID: "test-order-id",
        ),
      );
      when(mockHomeCubit.stream).thenAnswer(
        (_) => Stream.value(
          const HomeState(
            acceptOrderStatus: StateStatus.loading(),
            currentOrderID: "test-order-id",
          ),
        ),
      );

      // Act
      await tester.pumpWidget(prepareWidget(order: order));
      await tester.pump();

      // Assert
      expect(find.byType(LoadingButton), findsOneWidget);
      expect(find.byType(LoadingCircle), findsOneWidget);
    },
  );

  tearDown(() {
    getIt.reset();
  });
}
