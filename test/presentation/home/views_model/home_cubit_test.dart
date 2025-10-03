import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/domain/entities/product/product_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/accept_order/accept_order_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:flowery_tracking_app/domain/entities/store/store_entity.dart';
import 'package:flowery_tracking_app/domain/entities/user/user_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/accept_order/accept_order_use_case.dart';
import 'package:flowery_tracking_app/domain/use_cases/fetch_driver_pending_orders/fetch_driver_pending_orders_use_case.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_cubit.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_intent.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([FetchDriverPendingOrdersUseCase, AcceptOrderUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final MockFetchDriverPendingOrdersUseCase
  mockFetchDriverPendingOrdersUseCase;
  late final MockAcceptOrderUseCase mockAcceptOrderUseCase;
  late final List<OrderEntity> expectedOrdersList;
  late final AcceptOrderRequestEntity orderRequest;
  late HomeCubit cubit;

  setUpAll(() {
    mockFetchDriverPendingOrdersUseCase = MockFetchDriverPendingOrdersUseCase();
    mockAcceptOrderUseCase = MockAcceptOrderUseCase();
    expectedOrdersList = [
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
              description: "A beautiful bouquet of red roses",
              price: 200,
            ),
            price: 200,
            quantity: 1,
          ),
        ],
        totalPrice: 200,
        shippingAddress: ShippingAddressEntity(city: "Cairo"),
        paymentType: "Cash",
        isPaid: false,
        isDelivered: false,
        state: "Processing",
        orderNumber: "ORD-001",
        store: StoreEntity(name: "Flowery Store", address: "Downtown Cairo"),
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
              description: "A colorful mix of tulips",
              price: 350,
            ),
            price: 350,
            quantity: 2,
          ),
        ],
        totalPrice: 700,
        shippingAddress: ShippingAddressEntity(city: "Giza"),
        paymentType: "Credit Card",
        isPaid: true,
        isDelivered: true,
        state: "Delivered",
        orderNumber: "ORD-002",
        store: StoreEntity(name: "Flower Hub", address: "Mall of Egypt"),
      ),
    ];
    orderRequest = const AcceptOrderRequestEntity(
      orderId: "order_1",
      orderData: OrderEntity(
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
              description: "A beautiful bouquet of red roses",
              price: 200,
            ),
            price: 200,
            quantity: 1,
          ),
        ],
        totalPrice: 200,
        shippingAddress: ShippingAddressEntity(city: "Cairo"),
        paymentType: "Cash",
        isPaid: false,
        isDelivered: false,
        state: "Processing",
        orderNumber: "ORD-001",
        store: StoreEntity(name: "Flowery Store", address: "Downtown Cairo"),
      ),
    );
  });
  setUp(() {
    cubit = HomeCubit(
      mockFetchDriverPendingOrdersUseCase,
      mockAcceptOrderUseCase,
    );
  });

  group("Home cubit test", () {
    blocTest<HomeCubit, HomeState>(
      'emits [Loading, Success] when FetchDriverPendingOrdersIntent succeeds',
      build: () {
        final expectedSuccessResult = Success<List<OrderEntity>>(
          expectedOrdersList,
        );
        provideDummy<Result<List<OrderEntity>>>(expectedSuccessResult);
        when(
          mockFetchDriverPendingOrdersUseCase.invoke(),
        ).thenAnswer((_) async => expectedSuccessResult); // success
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const FetchDriverPendingOrdersIntent()),
      expect: () => [
        isA<HomeState>().having(
          (state) => state.pendingOrdersStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<HomeState>()
            .having(
              (state) => state.pendingOrdersStatus.isSuccess,
              "Is Success State",
              equals(true),
            )
            .having(
              (state) => state.pendingOrdersStatus.data?.length,
              "Is having the orders length as expected",
              equals(expectedOrdersList.length),
            )
            .having(
              (state) => state.pendingOrdersStatus.data?.elementAt(0).id,
              "Is having the order data as expected",
              equals(expectedOrdersList.elementAt(0).id),
            )
            .having(
              (state) => state.pendingOrdersStatus.data?.elementAt(0).state,
              "Is having the order data as expected",
              equals(expectedOrdersList.elementAt(0).state),
            )
            .having(
              (state) => state.pendingOrdersStatus.data
                  ?.elementAt(0)
                  .shippingAddress
                  ?.city,
              "Is having the order data as expected",
              equals(expectedOrdersList.elementAt(0).shippingAddress?.city),
            )
            .having(
              (state) =>
                  state.pendingOrdersStatus.data?.elementAt(0).totalPrice,
              "Is having the order data as expected",
              equals(expectedOrdersList.elementAt(0).totalPrice),
            )
            .having(
              (state) => state.pendingOrdersStatus.data
                  ?.elementAt(0)
                  .orderItems
                  ?.elementAt(0)
                  .id,
              "Is having the order data as expected",
              equals(
                expectedOrdersList.elementAt(0).orderItems?.elementAt(0).id,
              ),
            ),
        isA<HomeState>().having(
          (state) => state.isReloading,
          "isReloading value back to false",
          equals(false),
        ),
      ],
      verify: (_) {
        verify(mockFetchDriverPendingOrdersUseCase.invoke()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      "emits [Loading, Failure] when FetchDriverPendingOrdersIntent is Called",
      build: () {
        final expectedFailureResult = Failure<List<OrderEntity>>(
          responseException: const ResponseException(
            message: "failed to load orders",
          ),
        );
        provideDummy<Result<List<OrderEntity>>>(expectedFailureResult);
        when(
          mockFetchDriverPendingOrdersUseCase.invoke(),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const FetchDriverPendingOrdersIntent()),
      expect: () => [
        isA<HomeState>().having(
          (state) => state.pendingOrdersStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<HomeState>()
            .having(
              (state) => state.pendingOrdersStatus.isFailure,
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.pendingOrdersStatus.error?.message,
              'responseException.message',
              equals("failed to load orders"),
            ),
      ],
      verify: (_) {
        verify(mockFetchDriverPendingOrdersUseCase.invoke()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits [Loading, Success] when AcceptOrderIntent succeeds',
      build: () {
        final expectedSuccessResult = Success<void>(null);
        provideDummy<Result<void>>(expectedSuccessResult);
        when(
          mockAcceptOrderUseCase.invoke(request: anyNamed("request")),
        ).thenAnswer((_) async => expectedSuccessResult); // success
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: AcceptOrderIntent(request: orderRequest),
      ),
      expect: () => [
        isA<HomeState>().having(
          (state) =>
              state.acceptOrderStatus.isLoading &&
              state.currentOrderID == orderRequest.orderId,
          "Is Loading State",
          equals(true),
        ),
        isA<HomeState>().having(
          (state) =>
              state.acceptOrderStatus.isSuccess && state.currentOrderID == "",
          "Is Success State",
          equals(true),
        ),
        isA<HomeState>().having(
          (state) => state.acceptOrderStatus.isInitial,
          "Is back to initial state",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockAcceptOrderUseCase.invoke(request: anyNamed("request")),
        ).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      "emits [Loading, Failure] when AcceptOrderIntent is Called",
      build: () {
        final expectedFailureResult = Failure<void>(
          responseException: const ResponseException(
            message: "failed to accept order",
          ),
        );
        provideDummy<Result<void>>(expectedFailureResult);
        when(
          mockAcceptOrderUseCase.invoke(request: anyNamed("request")),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: AcceptOrderIntent(request: orderRequest),
      ),
      expect: () => [
        isA<HomeState>().having(
          (state) =>
              state.acceptOrderStatus.isLoading &&
              state.currentOrderID == orderRequest.orderId,
          "Is Loading State",
          equals(true),
        ),
        isA<HomeState>()
            .having(
              (state) =>
                  state.acceptOrderStatus.isFailure &&
                  state.currentOrderID == "",
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.acceptOrderStatus.error?.message,
              'responseException.message',
              equals("failed to accept order"),
            ),
        isA<HomeState>().having(
          (state) => state.acceptOrderStatus.isInitial,
          "Is back to initial state",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockAcceptOrderUseCase.invoke(request: anyNamed("request")),
        ).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      "emits a new list of orders after canceling an order when RejectOrderIntent is Called",
      build: () {
        cubit.state.pendingOrdersStatus.data?.addAll(expectedOrdersList);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(
        intent: RejectOrderIntent(orderId: expectedOrdersList.elementAt(0).id!),
      ),
      expect: () => [
        isA<HomeState>().having(
          (state) =>
              state.pendingOrdersStatus.data!.length <
              expectedOrdersList.length,
          "Is an order element canceled",
          equals(true),
        ),
      ],
    );
  });
}
