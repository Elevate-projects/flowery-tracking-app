import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/entities/edit_profile/edit_profile_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/edit_profile/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class EditProfileUseCase{
  final EditProfileRepository _repositories;
  EditProfileUseCase(this._repositories);
  Future<Result<DriverDataEntity>> editProfile(EditProfileRequestEntity request)async{
    return await _repositories.editProfile(request);
  }
}