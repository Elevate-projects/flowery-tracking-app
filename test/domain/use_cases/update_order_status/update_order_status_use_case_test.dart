import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/requests/order_details/update_order_status_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/order_details/order_details_repository.dart';
import 'package:flowery_tracking_app/domain/use_cases/update_order_status/update_order_status_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_order_status_use_case_test.mocks.dart';

@GenerateMocks([OrderDetailsRepository])
void main() {
  test(
    'when call updateCurrentDriverOrderStatus it should be called successfully from OrderDetailsRepository',
    () async {
      // Arrange
      final MockOrderDetailsRepository mockOrderDetailsRepository =
          MockOrderDetailsRepository();
      final UpdateOrderStatusUseCase updateOrderStatusUseCase =
          UpdateOrderStatusUseCase(mockOrderDetailsRepository);
      const request = UpdateOrderStatusRequestEntity(
        orderId: "1234",
        orderStatus: "completed",
      );
      final expectedResult = Success<void>(null);
      provideDummy<Result<void>>(expectedResult);

      when(
        mockOrderDetailsRepository.updateCurrentDriverOrderStatus(
          request: anyNamed("request"),
        ),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await updateOrderStatusUseCase.invoke(request: request);

      // Assert
      verify(
        mockOrderDetailsRepository.updateCurrentDriverOrderStatus(
          request: anyNamed("request"),
        ),
      ).called(1);
      expect(result, isA<Success<void>>());
    },
  );
}
