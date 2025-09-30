import 'package:flowery_tracking_app/domain/entities/requests/accept_order/accept_order_request_entity.dart';

sealed class HomeIntent {
  const HomeIntent();
}

final class HomeInitializationIntent extends HomeIntent {
  const HomeInitializationIntent();
}

final class FetchDriverPendingOrdersIntent extends HomeIntent {
  const FetchDriverPendingOrdersIntent();
}

final class AcceptOrderIntent extends HomeIntent {
  final AcceptOrderRequestEntity request;
  const AcceptOrderIntent({required this.request});
}

final class RejectOrderIntent extends HomeIntent {
  final String orderId;
  const RejectOrderIntent({required this.orderId});
}
