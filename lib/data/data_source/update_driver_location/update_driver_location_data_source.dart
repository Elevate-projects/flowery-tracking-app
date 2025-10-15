import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/update_driver_loc/update_driver_loc.dart';

abstract interface class UpdateDriverLocationDataSource {
  Future<Result<void>> updateDriverLocation(UpdateDriverLocationEntity request);
}
