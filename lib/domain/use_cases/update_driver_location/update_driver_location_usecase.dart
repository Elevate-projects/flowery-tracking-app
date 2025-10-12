import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/update_driver_loc/update_driver_loc.dart';
import 'package:flowery_tracking_app/domain/repositories/update_driver_loc/update_driver_location_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUpdateDriverLocationUseCase {
  final UpdateDriverLocationRepository _driverLocationRepository;

  const GetUpdateDriverLocationUseCase(this._driverLocationRepository);

  Future<Result<void>> execute(UpdateDriverLocationEntity request) {
    return _driverLocationRepository.updateDriverLocation(request);
  }
}
