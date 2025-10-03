import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/requests/adit_profile/edit_profile_request.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/edit_profile/edit_profile_repositories.dart';
import 'package:injectable/injectable.dart';
@injectable
class EditProfileUseCase{
  final EditProfileRepositories _repositories;
  EditProfileUseCase(this._repositories);
  Future<Result<DriverDataEntity>> editProfile(EditProfileRequestModel request){
    return _repositories.editProfile(request);
  }
}