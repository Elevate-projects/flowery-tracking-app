import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/domain/entities/product/product_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/accept_order/accept_order_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:flowery_tracking_app/domain/entities/store/store_entity.dart';
import 'package:flowery_tracking_app/domain/entities/user/user_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/home/home_repository.dart';
import 'package:flowery_tracking_app/domain/use_cases/accept_order/accept_order_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'accept_order_use_case_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockHomeRepository mockHomeRepository;
  late final AcceptOrderUseCase acceptOrderUseCase;
  setUpAll(() {
    mockHomeRepository = MockHomeRepository();
    acceptOrderUseCase = AcceptOrderUseCase(mockHomeRepository);
  });

  test(
    'when call acceptOrder it should be called successfully from HomeRepository',
    () async {
      // Arrange
      final AcceptOrderRequestEntity orderRequest =
          const AcceptOrderRequestEntity(
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
              store: StoreEntity(
                name: "Flowery Store",
                address: "Downtown Cairo",
              ),
            ),
          );
      final expectedResult = Success<void>(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockHomeRepository.acceptOrder(request: anyNamed("request")),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await acceptOrderUseCase.invoke(request: orderRequest);

      // Assert
      verify(
        mockHomeRepository.acceptOrder(request: anyNamed("request")),
      ).called(1);
      expect(result, isA<Success<void>>());
    },
  );
}
