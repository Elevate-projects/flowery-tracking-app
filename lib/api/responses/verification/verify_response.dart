import 'package:json_annotation/json_annotation.dart';

part 'verify_response.g.dart';

@JsonSerializable()
class VerifyResponse {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "code")
  final int? code;

  const VerifyResponse({this.status, this.message, this.code});

  factory VerifyResponse.fromJson(Map<String, dynamic> json) {
    return _$VerifyResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerifyResponseToJson(this);
  }
}
