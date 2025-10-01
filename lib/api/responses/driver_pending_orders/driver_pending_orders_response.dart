import 'package:flowery_tracking_app/api/models/order/order_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_pending_orders_response.g.dart';

@JsonSerializable()
final class DriverPendingOrdersResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "orders")
  final List<OrderModel>? orders;

  DriverPendingOrdersResponse({this.message, this.orders});

  factory DriverPendingOrdersResponse.fromJson(Map<String, dynamic> json) {
    return _$DriverPendingOrdersResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DriverPendingOrdersResponseToJson(this);
  }
}
