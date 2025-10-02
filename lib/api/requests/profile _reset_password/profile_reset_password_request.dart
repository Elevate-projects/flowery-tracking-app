import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_reset_password_request.g.dart';

@JsonSerializable()
class ProfileResetPasswordRequestModel extends Equatable {
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "newPassword")
  final String? newPassword;

  const ProfileResetPasswordRequestModel({this.password, this.newPassword});

  factory ProfileResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return _$ProfileResetPasswordRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileResetPasswordRequestModelToJson(this);
  }

  @override
  List<Object?> get props => [password, newPassword];
}
