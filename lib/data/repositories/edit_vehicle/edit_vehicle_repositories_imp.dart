
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/requests/edit_vehicle/edit_vehicle_request.dart';
import 'package:flowery_tracking_app/data/data_source/edit_vehicle/edit_vehicle_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/edit_vehicle/edit_vehicle_repositories.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:EditVehicleRepositories)
class EditVehicleRepositoriesImp implements EditVehicleRepositories{
  final EditVehicleDataSource _source;
  EditVehicleRepositoriesImp(this._source);
  @override
  Future<Result<DriverDataEntity>> editVehicle(EditVehicleRequest request) {
    return _source.editVehicle(request);
  }
}