import 'package:json_annotation/json_annotation.dart';

part 'update_order_status_request_model.g.dart';

@JsonSerializable()
class UpdateOrderStatusRequestModel {
  @JsonKey(name: "state")
  final String? state;

  UpdateOrderStatusRequestModel({this.state});

  factory UpdateOrderStatusRequestModel.fromJson(Map<String, dynamic> json) {
    return _$UpdateOrderStatusRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateOrderStatusRequestModelToJson(this);
  }
}
