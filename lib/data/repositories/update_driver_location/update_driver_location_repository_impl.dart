import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/update_driver_location/update_driver_location_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/update_driver_loc/update_driver_loc.dart';
import 'package:flowery_tracking_app/domain/repositories/update_driver_loc/update_driver_location_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UpdateDriverLocationRepository)
class UpdateDriverLocationRepositoryImpl
    implements UpdateDriverLocationRepository {
  final UpdateDriverLocationDataSource _driverLocationDataSource;

  const UpdateDriverLocationRepositoryImpl(this._driverLocationDataSource);

  @override
  Future<Result<void>> updateDriverLocation(
    UpdateDriverLocationEntity request,
  ) {
    return _driverLocationDataSource.updateDriverLocation(request);
  }
}
