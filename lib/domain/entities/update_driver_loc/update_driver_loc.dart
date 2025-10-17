final class UpdateDriverLocationEntity {
  final String orderId;
  final num lat;
  final num long;

  const UpdateDriverLocationEntity({
    required this.orderId,
    required this.lat,
    required this.long,
  });
}
