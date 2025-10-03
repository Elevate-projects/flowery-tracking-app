import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/profile/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileDataUseCase {
  final ProfileRepository _profileRepository;

  GetProfileDataUseCase(this._profileRepository);

  Future<Result<DriverDataEntity?>> call() {
    return _profileRepository.fetchUserData();
  }
}
