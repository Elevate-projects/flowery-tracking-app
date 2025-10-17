import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';

abstract interface class VehicleRepository {
  Future<Result<List<VehicleEntity>>> fetchAllVehicles();
}
