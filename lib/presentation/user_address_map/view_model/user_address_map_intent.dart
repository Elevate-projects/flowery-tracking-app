import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';

sealed class UserAddressMapIntent {
  const UserAddressMapIntent();
}

final class UserAddressMapInitializationIntent extends UserAddressMapIntent {
  const UserAddressMapInitializationIntent({required this.orderData});

  final OrderEntity orderData;
}
