import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/entities/edit_profile/edit_profile_entity.dart';
abstract interface class EditProfileRepositories{
  Future<Result<DriverDataEntity>> editProfile(EditProfileRequestEntity request);
}