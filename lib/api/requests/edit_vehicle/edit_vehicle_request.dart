import 'package:json_annotation/json_annotation.dart';
part 'edit_vehicle_request.g.dart';
@JsonSerializable()
final class EditVehicleRequest {
  @JsonKey(name: "vehicleType")
  final String? vehicleType;
  @JsonKey(name: "vehicleNumber")
  final String? vehicleNumber;
  @JsonKey(name: "vehicleLicense")
  final String? vehicleLicense;

  EditVehicleRequest ({
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
  });

  factory EditVehicleRequest.fromJson(Map<String, dynamic> json) {
    return _$EditVehicleRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EditVehicleRequestToJson(this);
  }
}


