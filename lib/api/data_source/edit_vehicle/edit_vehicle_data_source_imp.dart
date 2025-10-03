import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/requests/edit_vechicle/edit_vehicle_request.dart';
import 'package:flowery_tracking_app/data/data_source/edit_vehicle/edit_vehicle_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: EditVehicleDataSource)
class EditVehicleDataSourceImp implements EditVehicleDataSource {
  final ApiClient apiClient;
  EditVehicleDataSourceImp(this.apiClient);

  @override
  Future<Result<DriverDataEntity>> editVehicle(EditVehicleRequest request) async {
    return executeApi(() async {
      final result = await apiClient.editVehicle(
        "Bearer ${FloweryDriverMethodHelper.currentUserToken}",
        request,
      );
      return result.toDriverDataEntity();
    });
  }
}

