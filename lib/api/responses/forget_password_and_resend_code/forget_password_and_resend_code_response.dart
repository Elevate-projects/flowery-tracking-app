import 'package:json_annotation/json_annotation.dart';

part 'forget_password_and_resend_code_response.g.dart';

@JsonSerializable()
class ForgetPasswordAndResendCodeResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "info")
  final String? info;

  const ForgetPasswordAndResendCodeResponse({this.message, this.info});

  factory ForgetPasswordAndResendCodeResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return _$ForgetPasswordAndResendCodeResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgetPasswordAndResendCodeResponseToJson(this);
  }
}
