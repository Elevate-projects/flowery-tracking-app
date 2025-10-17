sealed class OrderDetailsIntent {
  const OrderDetailsIntent();
}

final class OrderDetailsInitializationIntent extends OrderDetailsIntent {
  const OrderDetailsInitializationIntent();
}

final class UpdateOrderStateIntent extends OrderDetailsIntent {
  const UpdateOrderStateIntent();
}

final class OpenWhatsAppIntent extends OrderDetailsIntent {
  final String phoneNumber;
  const OpenWhatsAppIntent({required this.phoneNumber});
}

final class OpenPhoneIntent extends OrderDetailsIntent {
  final String phoneNumber;
  const OpenPhoneIntent({required this.phoneNumber});
}
