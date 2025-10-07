import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/domain/entities/product/product_entity.dart';
import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:flowery_tracking_app/domain/entities/store/store_entity.dart';
import 'package:flowery_tracking_app/domain/entities/user/user_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/completed_driver_orders/completed_driver_orders_use_case.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_cubit.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_intent.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_cubit_test.mocks.dart';

@GenerateMocks([CompletedDriverOrdersUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final MockCompletedDriverOrdersUseCase mockCompletedDriverOrdersUseCase;
  late OrdersCubit cubit;

  late final List<OrderEntity> expectedOrders;

  setUpAll(() {
    mockCompletedDriverOrdersUseCase = MockCompletedDriverOrdersUseCase();

    expectedOrders = [
      const OrderEntity(
        id: "order_1",
        user: UserEntity(
          id: "user_1",
          firstName: "Ahmed",
          lastName: "Tarek",
          email: "ahmed@example.com",
        ),
        orderItems: [
          OrderItemEntity(
            id: "item_1",
            product: ProductEntity(
              id: "prod_1",
              description: "Red roses bouquet",
              price: 200,
            ),
            price: 200,
            quantity: 1,
          ),
        ],
        totalPrice: 200,
        shippingAddress: ShippingAddressEntity(city: "Cairo"),
        paymentType: "Cash",
        isPaid: true,
        isDelivered: true,
        state: "deliveredToTheUser",
        orderNumber: "ORD-001",
        store: StoreEntity(name: "Flowery", address: "Downtown Cairo"),
      ),
      const OrderEntity(
        id: "order_2",
        user: UserEntity(
          id: "user_2",
          firstName: "Mona",
          lastName: "Ali",
          email: "mona@example.com",
        ),
        orderItems: [
          OrderItemEntity(
            id: "item_2",
            product: ProductEntity(
              id: "prod_2",
              description: "Tulips mix",
              price: 150,
            ),
            price: 150,
            quantity: 2,
          ),
        ],
        totalPrice: 300,
        shippingAddress: ShippingAddressEntity(city: "Giza"),
        paymentType: "Credit Card",
        isPaid: true,
        isDelivered: true,
        state: "canceled",
        orderNumber: "ORD-002",
        store: StoreEntity(name: "Flower Hub", address: "Mall of Egypt"),
      ),
    ];
  });

  setUp(() {
    cubit = OrdersCubit(mockCompletedDriverOrdersUseCase);
  });

  group('OrdersCubit Tests', () {
    blocTest<OrdersCubit, OrdersState>(
      'emits [Loading, Success] when OrdersInitializationIntent succeeds',
      build: () {
        final expectedResult = Success<List<OrderEntity>>(expectedOrders);
        provideDummy<Result<List<OrderEntity>>>(expectedResult);
        when(
          mockCompletedDriverOrdersUseCase.invoke(),
        ).thenAnswer((_) async => expectedResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const OrdersInitializationIntent()),
      expect: () => [
        // Loading state
        isA<OrdersState>().having(
          (state) => state.driverOrdersStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        // Success state
        isA<OrdersState>()
            .having(
              (state) => state.driverOrdersStatus.isSuccess,
              "Is Success State",
              equals(true),
            )
            .having(
              (state) =>
                  state.driverOrdersStatus.data?.length ==
                  expectedOrders.length,
              "Orders Count Matches",
              equals(true),
            )
            .having(
              (state) => state.completedOrders,
              "Completed Orders Count",
              equals("1"),
            )
            .having(
              (state) => state.canceledOrders,
              "Canceled Orders Count",
              equals("1"),
            ),
      ],
      verify: (_) {
        verify(mockCompletedDriverOrdersUseCase.invoke()).called(1);
      },
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits [Loading, Failure] when OrdersInitializationIntent fails',
      build: () {
        final expectedFailure = Failure<List<OrderEntity>>(
          responseException: const ResponseException(
            message: "failed to load orders",
          ),
        );
        provideDummy<Result<List<OrderEntity>>>(expectedFailure);
        when(
          mockCompletedDriverOrdersUseCase.invoke(),
        ).thenAnswer((_) async => expectedFailure);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const OrdersInitializationIntent()),
      expect: () => [
        // Loading
        isA<OrdersState>().having(
          (state) => state.driverOrdersStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        // Failure
        isA<OrdersState>()
            .having(
              (state) => state.driverOrdersStatus.isFailure,
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.driverOrdersStatus.error?.message,
              "Error Message",
              equals("failed to load orders"),
            ),
      ],
      verify: (_) {
        verify(mockCompletedDriverOrdersUseCase.invoke()).called(1);
      },
    );
  });
}
