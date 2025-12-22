import 'dart:io';

import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/upload_photo_response_entity/upload_photo_response_entity.dart';

abstract class UploadPhotoDataSource {
  Future<Result<UploadPhotoResponseEntity>> uploadPhoto(File photoFile);
}
