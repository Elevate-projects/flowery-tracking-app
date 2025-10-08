import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/profile/remote_data_source/profile_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;

  const ProfileRepositoryImpl(this._profileRemoteDataSource);

  @override
  Future<Result<DriverDataEntity?>> fetchUserData() {
    return _profileRemoteDataSource.fetchUserData();
  }
}
