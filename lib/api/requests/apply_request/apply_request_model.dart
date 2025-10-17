import 'dart:io';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart';

part 'apply_request_model.g.dart';

@JsonSerializable()
class ApplyRequestModel {
  @JsonKey(name: 'country')
  final String country;

  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'vehicleType')
  final String vehicleType;

  @JsonKey(name: 'vehicleNumber')
  final String vehicleNumber;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? vehicleLicense;

  @JsonKey(name: 'NID')
  final String nid;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? nidImg;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'rePassword')
  final String rePassword;

  @JsonKey(name: 'gender')
  final String gender;

  @JsonKey(name: 'phone')
  final String phone;

  ApplyRequestModel({
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

  factory ApplyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ApplyRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyRequestModelToJson(this);

  /// Convert request into Dio FormData (strings + optional files)
  Future<FormData> toFormData() async {
    final map = Map<String, dynamic>.from(toJson());

    if (vehicleLicense != null) {
      map['vehicleLicense'] = await MultipartFile.fromFile(
        vehicleLicense!.path,
        filename: basename(vehicleLicense!.path),
      );
    }

    if (nidImg != null) {
      map['NIDImg'] = await MultipartFile.fromFile(
        nidImg!.path,
        filename: basename(nidImg!.path),
      );
    }

    return FormData.fromMap(map);
  }
}
