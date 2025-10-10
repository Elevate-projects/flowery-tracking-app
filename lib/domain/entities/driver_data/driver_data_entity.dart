import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class DriverDataEntity extends Equatable {
  DriverDataEntity({
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nid,
    this.nIDImg,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.id,
  });

  String? country;
  String? firstName;
  String? lastName;
  String? vehicleType;
  String? vehicleNumber;
  String? vehicleLicense;
  String? nid;
  String? nIDImg;
  String? email;
  String? gender;
  String? phone;
  String? photo;
  String? role;
  String? id;

  @override
  List<Object?> get props => [
    country,
    firstName,
    lastName,
    vehicleType,
    vehicleNumber,
    vehicleLicense,
    nid,
    nIDImg,
    email,
    gender,
    phone,
    photo,
    role,
    id,
  ];
}
