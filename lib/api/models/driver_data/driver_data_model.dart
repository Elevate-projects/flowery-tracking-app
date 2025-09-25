import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_data_model.g.dart';

@JsonSerializable()
class DriverDataModel {
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "vehicleType")
  final String? vehicleType;
  @JsonKey(name: "vehicleNumber")
  final String? vehicleNumber;
  @JsonKey(name: "vehicleLicense")
  final String? vehicleLicense;
  @JsonKey(name: "NID")
  final String? nID;
  @JsonKey(name: "NIDImg")
  final String? nIDImg;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "photo")
  final String? photo;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  DriverDataModel({
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nID,
    this.nIDImg,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.id,
    this.createdAt,
  });

  factory DriverDataModel.fromJson(Map<String, dynamic> json) {
    return _$DriverDataModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DriverDataModelToJson(this);
  }

  DriverDataEntity toDriverDataEntity() {
    return DriverDataEntity(
      id: id,
      gender: gender,
      phone: phone,
      photo: photo,
      role: role,
      country: country,
      firstName: firstName,
      lastName: lastName,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
      nid: nID,
      nIDImg: nIDImg,
      email: email,
    );
  }
}
