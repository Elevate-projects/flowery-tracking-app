import 'package:flowery_tracking_app/api/models/order/order_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_order_model.g.dart';

@JsonSerializable()
class DriverOrderModel {
  @JsonKey(name: "order")
  final OrderModel? order;

  DriverOrderModel({this.order});

  factory DriverOrderModel.fromJson(Map<String, dynamic> json) {
    return _$DriverOrderModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DriverOrderModelToJson(this);
  }

  static DriverOrderModel empty() => DriverOrderModel();
}
