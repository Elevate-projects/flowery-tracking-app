import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password_and_resend_code_request_model.g.dart';

@JsonSerializable()
class ForgetPasswordAndResendCodeRequestModel extends Equatable {
  @JsonKey(name: "email")
  final String? email;

  const ForgetPasswordAndResendCodeRequestModel({this.email});

  factory ForgetPasswordAndResendCodeRequestModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return _$ForgetPasswordAndResendCodeRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgetPasswordAndResendCodeRequestModelToJson(this);
  }

  @override
  List<Object?> get props => [email];
}
