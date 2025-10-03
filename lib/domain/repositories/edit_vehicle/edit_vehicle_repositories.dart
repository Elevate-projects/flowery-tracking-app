import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/requests/edit_vechicle/edit_vehicle_request.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';

abstract interface class EditVehicleRepositories{
  Future<Result<DriverDataEntity>> editVehicle(EditVehicleRequest request);
}