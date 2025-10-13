import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/entities/edit_vehicle/edit_vehicle_entity.dart';

abstract interface class EditVehicleRepository{
  Future<Result<DriverDataEntity>> editVehicle(EditVehicleEntity request);
}