import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/edit_vehicle/edit_vehicle_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/entities/edit_vehicle/edit_vehicle_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/edit_vehicle/edit_vehicle_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:EditVehicleRepository)
class EditVehicleRepositoryImpl implements EditVehicleRepository{
  final EditVehicleDataSource _source;
  EditVehicleRepositoryImpl(this._source);
  @override
  Future<Result<DriverDataEntity>> editVehicle(EditVehicleEntity request) {
    return _source.editVehicle(request);
  }
}