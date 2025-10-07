import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/edit_vehicle/edit_vehicle_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/entities/edit_vehicle/edit_vehicle_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/edit_vehicle/edit_vehicle_repositories.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:EditVehicleRepositories)
class EditVehicleRepositoriesImpl implements EditVehicleRepositories{
  final EditVehicleDataSource _source;
  EditVehicleRepositoriesImpl(this._source);
  @override
  Future<Result<DriverDataEntity>> editVehicle(EditVehicleEntity request) {
    return _source.editVehicle(request);
  }
}