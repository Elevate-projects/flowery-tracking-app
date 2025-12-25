import 'dart:io';


import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/edit_profile/upload_photo_data_source.dart';
import 'package:flowery_tracking_app/domain/repositories/edit_profile/upload_photo_repository.dart';
import 'package:flowery_tracking_app/domain/upload_photo_response_entity/upload_photo_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UploadPhotoRepository)
class UploadPhotoRepositoryImpl implements UploadPhotoRepository {
  final UploadPhotoDataSource _dataSource;

  UploadPhotoRepositoryImpl(this._dataSource);

  @override
  Future<Result<UploadPhotoResponseEntity>> uploadPhoto(File photoFile) {
    return _dataSource.uploadPhoto(photoFile);
  }
}
