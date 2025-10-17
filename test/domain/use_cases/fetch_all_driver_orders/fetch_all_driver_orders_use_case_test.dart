import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/repositories/order_details/order_details_repository.dart';
import 'package:flowery_tracking_app/domain/use_cases/fetch_all_driver_orders/fetch_all_driver_orders_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_all_driver_orders_use_case_test.mocks.dart';

@GenerateMocks([OrderDetailsRepository])
void main() {
  test(
    'when call fetchAllDriverOrders it should be called successfully from OrderDetailsRepository and returns the order Id',
    () async {
      // Arrange
      final MockOrderDetailsRepository mockOrderDetailsRepository =
          MockOrderDetailsRepository();
      final FetchAllDriverOrdersUseCase fetchAllDriverOrdersUseCase =
          FetchAllDriverOrdersUseCase(mockOrderDetailsRepository);
      final expectedResult = Success<String?>("12345");
      provideDummy<Result<String?>>(expectedResult);

      when(
        mockOrderDetailsRepository.fetchAllDriverOrders(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await fetchAllDriverOrdersUseCase.invoke();

      // Assert
      verify(mockOrderDetailsRepository.fetchAllDriverOrders()).called(1);
      expect(result, isA<Success<String?>>());
      final successResult = result as Success<String?>;
      expect(successResult.data, equals(expectedResult.data));
    },
  );
}
