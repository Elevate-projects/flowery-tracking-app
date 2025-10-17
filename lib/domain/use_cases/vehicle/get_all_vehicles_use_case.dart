import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/vehicle/vehicle_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllVehiclesUseCase {
  final VehicleRepository _vehicleRepository;
  const GetAllVehiclesUseCase(this._vehicleRepository);

  Future<Result<List<VehicleEntity>>> invoke() async {
    return await _vehicleRepository.fetchAllVehicles();
  }
}
