import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';

final class AcceptOrderRequestEntity {
  final String orderId;
  final OrderEntity orderData;

  const AcceptOrderRequestEntity({
    required this.orderId,
    required this.orderData,
  });
}
