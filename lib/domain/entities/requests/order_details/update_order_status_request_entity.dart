final class UpdateOrderStatusRequestEntity {
  final String orderId;
  final String orderStatus;
  const UpdateOrderStatusRequestEntity({
    required this.orderId,
    required this.orderStatus,
  });
}
