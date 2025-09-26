import 'dart:io';

class ApplyRequestEntity {
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final File? vehicleLicense;
  final String nid;
  final File? nidImg;
  final String email;
  final String password;
  final String rePassword;
  final String gender;
  final String phone;

  ApplyRequestEntity({
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    this.vehicleLicense,
    required this.nid,
    this.nidImg,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.gender,
    required this.phone,
  });
}
