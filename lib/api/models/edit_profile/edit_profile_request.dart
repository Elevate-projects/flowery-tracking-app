import 'package:json_annotation/json_annotation.dart';
part 'edit_profile_request.g.dart';

@JsonSerializable()
final class EditProfileRequestModel {
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "email")
  final String? email;

  EditProfileRequestModel ({
    this.lastName,
    this.firstName,
    this.phone,
    this.email,
  });

  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) {
    return _$EditProfileRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EditProfileRequestModelToJson(this);
  }
}


