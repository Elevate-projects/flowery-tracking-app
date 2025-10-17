import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/vehicle/remote_data_source/vehicle_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/vehicle/vehicle_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VehicleRepository)
class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleRemoteDataSource _vehicleRemoteDataSource;
  const VehicleRepositoryImpl(this._vehicleRemoteDataSource);

  @override
  Future<Result<List<VehicleEntity>>> fetchAllVehicles() async {
    return await _vehicleRemoteDataSource.fetchAllVehicles();
  }
}
