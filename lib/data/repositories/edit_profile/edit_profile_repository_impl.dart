import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/edit_profile/edit_profile_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/entities/edit_profile/edit_profile_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/edit_profile/edit_profile_repositories.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:EditProfileRepositories)
class EditProfileRepositoriesImpl implements EditProfileRepositories{
  final EditProfileRemoteDataSource _dataSource;
  EditProfileRepositoriesImpl(this._dataSource);
  @override
  Future<Result<DriverDataEntity>> editProfile(EditProfileRequestEntity request) {
    return _dataSource.editProfile(request);
  }
}