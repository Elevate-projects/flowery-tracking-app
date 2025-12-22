import 'package:flowery_tracking_app/domain/upload_photo_response_entity/upload_photo_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_photo_response.g.dart';

@JsonSerializable()
class UploadPhotoResponse {
  @JsonKey(name: "message")
  final String? message;

  const UploadPhotoResponse({
    this.message,
  });

  factory UploadPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadPhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadPhotoResponseToJson(this);

  UploadPhotoResponseEntity toUploadPhotoResponseEntity() {
    return UploadPhotoResponseEntity(
      message: message,
    );
  }
}