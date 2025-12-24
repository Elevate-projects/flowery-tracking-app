import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';

sealed class PickUpMapIntent {
  const PickUpMapIntent();
}

final class PickUpMapInitializationIntent extends PickUpMapIntent {
  const PickUpMapInitializationIntent({required this.orderData});

  final OrderEntity orderData;
}

final class RecenterCameraOnDriverIntent extends PickUpMapIntent {
  const RecenterCameraOnDriverIntent();
}
