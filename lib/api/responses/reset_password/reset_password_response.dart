import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "code")
  final int? code;

  const ResetPasswordResponse({this.message, this.token, this.code});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResetPasswordResponseToJson(this);
  }
}
