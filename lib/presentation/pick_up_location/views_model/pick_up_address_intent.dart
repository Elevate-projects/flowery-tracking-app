import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';

sealed class PickupAddressIntent {}

final class PickupAddressInitIntent extends PickupAddressIntent {
  final OrderEntity orderData;
  PickupAddressInitIntent({required this.orderData});
}
