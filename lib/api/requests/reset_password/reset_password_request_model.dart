import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request_model.g.dart';

@JsonSerializable()
class ResetPasswordRequestModel extends Equatable {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "newPassword")
  final String? newPassword;

  const ResetPasswordRequestModel({this.email, this.newPassword});

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestModelToJson(this);

  @override
  List<Object?> get props => [email, newPassword];
}
