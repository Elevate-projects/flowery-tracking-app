import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/vehicle/remote_data_source/vehicle_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VehicleRemoteDataSource)
class VehicleRemoteDataSourceImpl implements VehicleRemoteDataSource {
  final ApiClient _apiClient;
  const VehicleRemoteDataSourceImpl(this._apiClient);
  @override
  Future<Result<List<VehicleEntity>>> fetchAllVehicles() async {
    return executeApi(() async {
      final response = await _apiClient.getAllVehicles();
      final List<VehicleEntity> vehicles =
          response.vehicles
              ?.map((vehicle) => vehicle.toVehicleEntity())
              .toList() ??
          [];
      return vehicles;
    });
  }
}
