import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/cache/shared_preferences_helper.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/domain/entities/product/product_entity.dart';
import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:flowery_tracking_app/domain/entities/store/store_entity.dart';
import 'package:flowery_tracking_app/domain/entities/user/user_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/fetch_current_driver_order/fetch_current_driver_order_use_case.dart';
import 'package:flowery_tracking_app/domain/use_cases/update_order_status/update_order_status_use_case.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_intent.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../../fake_url_launcher.dart';
import 'order_details_cubit_test.mocks.dart';

@GenerateMocks([
  FetchCurrentDriverOrderUseCase,
  UpdateOrderStatusUseCase,
  SharedPreferencesHelper,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final MockFetchCurrentDriverOrderUseCase
  mockFetchCurrentDriverOrderUseCase;
  late final MockUpdateOrderStatusUseCase mockUpdateOrderStatusUseCase;
  late final MockSharedPreferencesHelper mockSharedPreferencesHelper;
  late OrderDetailsCubit cubit;
  late final OrderEntity expectedCurrentOrder;
  late final String testPhone;
  late FakeUrlLauncher fakeLauncher;

  setUpAll(() {
    mockFetchCurrentDriverOrderUseCase = MockFetchCurrentDriverOrderUseCase();
    mockSharedPreferencesHelper = MockSharedPreferencesHelper();
    mockUpdateOrderStatusUseCase = MockUpdateOrderStatusUseCase();
    expectedCurrentOrder = const OrderEntity(
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
      state: "inProgress",
      orderNumber: "ORD-002",
      store: StoreEntity(name: "Flower Hub", address: "Mall of Egypt"),
    );
    testPhone = "+201234567890";
    when(
      mockSharedPreferencesHelper.getBool(key: ConstKeys.isArLanguage),
    ).thenAnswer((_) => false);
  });
  setUp(() {
    fakeLauncher = FakeUrlLauncher();
    UrlLauncherPlatform.instance = fakeLauncher;
    cubit = OrderDetailsCubit(
      mockFetchCurrentDriverOrderUseCase,
      mockUpdateOrderStatusUseCase,
      mockSharedPreferencesHelper,
    );
  });

  group("OrderDetails cubit test", () {
    blocTest<OrderDetailsCubit, OrderDetailsState>(
      'emits [Loading, Success] when OrderDetailsInitializationIntent succeeds',
      build: () {
        final expectedSuccessResult = Success<OrderEntity>(
          expectedCurrentOrder,
        );
        provideDummy<Result<OrderEntity>>(expectedSuccessResult);
        when(
          mockFetchCurrentDriverOrderUseCase.invoke(
            orderId: anyNamed("orderId"),
          ),
        ).thenAnswer((_) => Stream.value(expectedSuccessResult));
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: const OrderDetailsInitializationIntent(),
      ),
      expect: () => [
        isA<OrderDetailsState>().having(
          (state) => state.orderStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<OrderDetailsState>()
            .having(
              (state) => state.orderStatus.isSuccess,
              "Is Success State",
              equals(true),
            )
            .having(
              (state) =>
                  state.orderStatus.data != null &&
                  state.currentOrderState.name ==
                      CurrentOrderState.inProgress.name,
              "Is Success Data equals expected Data",
              equals(true),
            )
            .having(
              (state) => state.orderStatus.data?.id,
              "Is Success Data equals expected Data",
              equals(expectedCurrentOrder.id),
            )
            .having(
              (state) => state.orderStatus.data?.state,
              "Is Success Data equals expected Data",
              equals(expectedCurrentOrder.state),
            )
            .having(
              (state) => state.orderStatus.data?.paymentType,
              "Is Success Data equals expected Data",
              equals(expectedCurrentOrder.paymentType),
            ),
      ],
      verify: (_) {
        verify(
          mockFetchCurrentDriverOrderUseCase.invoke(
            orderId: anyNamed("orderId"),
          ),
        ).called(1);
      },
    );

    blocTest<OrderDetailsCubit, OrderDetailsState>(
      "emits [Loading, Failure] when OrderDetailsInitializationIntent is Called",
      build: () {
        final expectedFailureResult = Failure<OrderEntity>(
          responseException: const ResponseException(
            message: "failed to load order data",
          ),
        );
        provideDummy<Result<OrderEntity>>(expectedFailureResult);
        when(
          mockFetchCurrentDriverOrderUseCase.invoke(
            orderId: anyNamed("orderId"),
          ),
        ).thenAnswer((_) => Stream.value(expectedFailureResult));
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: const OrderDetailsInitializationIntent(),
      ),
      expect: () => [
        isA<OrderDetailsState>().having(
          (state) => state.orderStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<OrderDetailsState>()
            .having(
              (state) => state.orderStatus.isFailure,
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.orderStatus.error?.message,
              'responseException.message',
              equals("failed to load order data"),
            ),

        isA<OrderDetailsState>().having(
          (state) => state.orderStatus.isInitial,
          "Is Initial State Again",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockFetchCurrentDriverOrderUseCase.invoke(
            orderId: anyNamed("orderId"),
          ),
        ).called(1);
      },
    );

    blocTest<OrderDetailsCubit, OrderDetailsState>(
      'emits [Loading, Success] when UpdateOrderStateIntent succeeds',
      build: () {
        final expectedSuccessResult = Success<void>(null);
        provideDummy<Result<void>>(expectedSuccessResult);
        when(
          mockUpdateOrderStatusUseCase.invoke(request: anyNamed("request")),
        ).thenAnswer((_) async => expectedSuccessResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const UpdateOrderStateIntent()),
      expect: () => [
        isA<OrderDetailsState>().having(
          (state) => state.updateOrderStateStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<OrderDetailsState>()
            .having(
              (state) => state.updateOrderStateStatus.isSuccess,
              "Is Success State",
              equals(true),
            )
            .having(
              (state) =>
                  state.currentOrderState.name !=
                  CurrentOrderState.inProgress.name,
              "Is Success Data equals expected Data",
              equals(true),
            ),
      ],
      verify: (_) {
        verify(
          mockUpdateOrderStatusUseCase.invoke(request: anyNamed("request")),
        ).called(1);
      },
    );

    blocTest<OrderDetailsCubit, OrderDetailsState>(
      "emits [Loading, Failure] when UpdateOrderStateIntent is Called",
      build: () {
        final expectedFailureResult = Failure<void>(
          responseException: const ResponseException(
            message: "failed to update state",
          ),
        );
        provideDummy<Result<void>>(expectedFailureResult);
        when(
          mockUpdateOrderStatusUseCase.invoke(request: anyNamed("request")),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const UpdateOrderStateIntent()),
      expect: () => [
        isA<OrderDetailsState>().having(
          (state) => state.updateOrderStateStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<OrderDetailsState>()
            .having(
              (state) => state.updateOrderStateStatus.isFailure,
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.updateOrderStateStatus.error?.message,
              'responseException.message',
              equals("failed to update state"),
            ),

        isA<OrderDetailsState>().having(
          (state) => state.updateOrderStateStatus.isInitial,
          "Is Initial State Again",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockUpdateOrderStatusUseCase.invoke(request: anyNamed("request")),
        ).called(1);
      },
    );

    blocTest<OrderDetailsCubit, OrderDetailsState>(
      'emits [Loading, Success] when OpenWhatsAppIntent succeeds',
      build: () {
        fakeLauncher.canLaunchResult = true;
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: OpenWhatsAppIntent(phoneNumber: testPhone),
      ),
      expect: () => [
        isA<OrderDetailsState>().having(
          (state) =>
              state.openWhatsappStatus.isLoading &&
              state.isOpeningWhatsapp &&
              state.selectedPhoneNumber == testPhone,
          "Is Loading State",
          equals(true),
        ),
        isA<OrderDetailsState>().having(
          (state) =>
              state.openWhatsappStatus.isSuccess &&
              !state.isOpeningWhatsapp &&
              state.selectedPhoneNumber == "",
          "Is Success State",
          equals(true),
        ),
      ],
    );

    blocTest<OrderDetailsCubit, OrderDetailsState>(
      'emits [Loading, Failure, Initial] when WhatsApp launch fails',
      build: () {
        fakeLauncher.shouldThrow = true;
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: OpenWhatsAppIntent(phoneNumber: testPhone),
      ),
      expect: () => [
        isA<OrderDetailsState>().having(
          (state) => state.openWhatsappStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<OrderDetailsState>().having(
          (state) => state.openWhatsappStatus.isFailure,
          "Is Failure State",
          equals(true),
        ),
        isA<OrderDetailsState>().having(
          (state) => state.openWhatsappStatus.isInitial,
          "Is Initial State Again",
          equals(true),
        ),
      ],
    );

    blocTest<OrderDetailsCubit, OrderDetailsState>(
      'emits [Loading, Success] when phone dialer opens successfully',
      build: () {
        fakeLauncher.canLaunchResult = true;
        fakeLauncher.shouldThrow = false;
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: OpenPhoneIntent(phoneNumber: testPhone)),
      expect: () => [
        isA<OrderDetailsState>().having(
          (state) =>
              state.openPhoneStatus.isLoading &&
              state.isOpeningPhone &&
              state.selectedPhoneNumber == testPhone,
          'Loading state emitted',
          true,
        ),
        isA<OrderDetailsState>().having(
          (state) =>
              state.openPhoneStatus.isSuccess &&
              !state.isOpeningPhone &&
              state.selectedPhoneNumber.isEmpty,
          'Success state emitted',
          true,
        ),
      ],
      verify: (_) {
        expect(fakeLauncher.launchedUrls, contains('tel:$testPhone'));
      },
    );

    blocTest<OrderDetailsCubit, OrderDetailsState>(
      'emits [Loading, Failure, Initial] when launch throws an exception',
      build: () {
        fakeLauncher.shouldThrow = true;
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: OpenPhoneIntent(phoneNumber: testPhone)),
      expect: () => [
        isA<OrderDetailsState>().having(
          (state) =>
              state.openPhoneStatus.isLoading &&
              state.isOpeningPhone &&
              state.selectedPhoneNumber == testPhone,
          'Loading state emitted',
          true,
        ),
        isA<OrderDetailsState>().having(
          (state) =>
              state.openPhoneStatus.isFailure &&
              state.openPhoneStatus.error?.message ==
                  AppText.openPhoneFailureMessage,
          'Failure state emitted with correct message',
          true,
        ),
        isA<OrderDetailsState>().having(
          (state) =>
              state.openPhoneStatus.isInitial &&
              !state.isOpeningPhone &&
              state.selectedPhoneNumber.isEmpty,
          'Reset to initial state after failure',
          true,
        ),
      ],
    );
  });
}
