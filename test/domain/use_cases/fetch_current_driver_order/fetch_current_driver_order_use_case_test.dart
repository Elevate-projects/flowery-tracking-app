import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/user/user_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/order_details/order_details_repository.dart';
import 'package:flowery_tracking_app/domain/use_cases/fetch_current_driver_order/fetch_current_driver_order_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_current_driver_order_use_case_test.mocks.dart';

@GenerateMocks([OrderDetailsRepository])
void main() {
  test(
    'when call fetchAllDriverOrders it should be called successfully from OrderDetailsRepository and returns the order Id',
    () async {
      // Arrange
      final MockOrderDetailsRepository mockOrderDetailsRepository =
          MockOrderDetailsRepository();
      final FetchCurrentDriverOrderUseCase fetchCurrentDriverOrderUseCase =
          FetchCurrentDriverOrderUseCase(mockOrderDetailsRepository);
      final String orderId = "12345";
      final expectedResult = OrderEntity(
        id: orderId,
        state: "inProgress",
        paymentType: "cash",
        totalPrice: 3560,
        user: const UserEntity(firstName: "Ahmed", lastName: "Tarek"),
      );
      final expectedSuccessResult = Success<OrderEntity>(expectedResult);
      provideDummy<Result<OrderEntity>>(expectedSuccessResult);

      when(
        mockOrderDetailsRepository.fetchCurrentDriverOrder(
          orderId: anyNamed("orderId"),
        ),
      ).thenAnswer((_) async => expectedSuccessResult);

      // Act
      final result = await fetchCurrentDriverOrderUseCase.invoke(
        orderId: orderId,
      );

      // Assert
      verify(
        mockOrderDetailsRepository.fetchCurrentDriverOrder(
          orderId: anyNamed("orderId"),
        ),
      ).called(1);
      expect(result, isA<Success<OrderEntity>>());
      final successResult = result as Success<OrderEntity>;
      expect(successResult.data.id, equals(expectedResult.id));
      expect(successResult.data.state, equals(expectedResult.state));
      expect(
        successResult.data.paymentType,
        equals(expectedResult.paymentType),
      );
      expect(successResult.data.totalPrice, equals(expectedResult.totalPrice));
      expect(
        successResult.data.user?.firstName,
        equals(expectedResult.user?.firstName),
      );
      expect(
        successResult.data.user?.lastName,
        equals(expectedResult.user?.lastName),
      );
    },
  );
}
