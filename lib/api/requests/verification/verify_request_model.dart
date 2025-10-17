import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_request_model.g.dart';

@JsonSerializable()
class VerifyRequestModel extends Equatable {
  @JsonKey(name: "resetCode")
  final String? resetCode;

  const VerifyRequestModel({this.resetCode});

  factory VerifyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyRequestModelToJson(this);

  @override
  List<Object?> get props => [resetCode];
}
