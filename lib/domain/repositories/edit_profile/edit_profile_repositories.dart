import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/requests/adit_profile/edit_profile_request.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
abstract interface class EditProfileRepositories{
  Future<Result<DriverDataEntity>> editProfile(EditProfileRequestModel request);
}