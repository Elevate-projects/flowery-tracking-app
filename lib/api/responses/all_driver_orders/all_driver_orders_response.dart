import 'package:flowery_tracking_app/api/models/driver_order/driver_order_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_driver_orders_response.g.dart';

@JsonSerializable()
class AllDriverOrdersResponse {
  @JsonKey(name: "orders")
  final List<DriverOrderModel>? orders;

  AllDriverOrdersResponse({this.orders});

  factory AllDriverOrdersResponse.fromJson(Map<String, dynamic> json) {
    return _$AllDriverOrdersResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllDriverOrdersResponseToJson(this);
  }
}
