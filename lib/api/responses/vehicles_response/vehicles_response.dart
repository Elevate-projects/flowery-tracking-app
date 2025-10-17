import 'package:flowery_tracking_app/api/models/vehicle/vehicle_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicles_response.g.dart';

@JsonSerializable()
class VehiclesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "vehicles")
  final List<VehicleModel>? vehicles;

  VehiclesResponse({this.message, this.vehicles});

  factory VehiclesResponse.fromJson(Map<String, dynamic> json) {
    return _$VehiclesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VehiclesResponseToJson(this);
  }
}
