import 'package:json_annotation/json_annotation.dart';

part 'profile_reset_password_response.g.dart';

@JsonSerializable()
class ProfileResetPasswordResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;

  ProfileResetPasswordResponse({this.message, this.token});

  factory ProfileResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileResetPasswordResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileResetPasswordResponseToJson(this);
  }
}
