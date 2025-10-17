import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_model.g.dart';

@JsonSerializable()
class VehicleModel {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? v;

  VehicleModel({
    this.id,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return _$VehicleModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VehicleModelToJson(this);
  }

  VehicleEntity toVehicleEntity() {
    return VehicleEntity(id: id ?? "", type: type ?? "");
  }
}
