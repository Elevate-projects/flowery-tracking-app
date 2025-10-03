import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/requests/edit_vehicle/edit_vehicle_request.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/edit_vehicle/edit_vehicle_repositories.dart';
import 'package:injectable/injectable.dart';
@injectable
class EditVehicleUseCase{
  final EditVehicleRepositories _repositories;
  EditVehicleUseCase(this._repositories);
  Future<Result<DriverDataEntity>> editVehicle(EditVehicleRequest request){
    return _repositories.editVehicle(request);
  }
}