import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_mapper.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/data/data_source/edit_vehicle/edit_vehicle_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/entities/edit_vehicle/edit_vehicle_entity.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';


import 'package:injectable/injectable.dart';
@Injectable(as: EditVehicleDataSource)
class EditVehicleDataSourceImpl implements EditVehicleDataSource {
  final ApiClient apiClient;
  EditVehicleDataSourceImpl(this.apiClient);

  @override
  Future<Result<DriverDataEntity>> editVehicle(EditVehicleEntity request) async {
    return executeApi(() async {
      final token = FloweryDriverMethodHelper.currentUserToken;
      if (token == null) {
        throw Exception(AppText.userNotFound);
      }
      final result = await apiClient.editVehicle(
          token: "Bearer ${FloweryDriverMethodHelper.currentUserToken}",
          request: RequestMapper.toEditVehicleRequest(request)
      );
      final entity =  result.toDriverDataEntity();
      FloweryDriverMethodHelper.driverData = entity;
      return entity;
    });
  }
}
