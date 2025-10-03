import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/requests/adit_profile/edit_profile_request.dart';
import 'package:flowery_tracking_app/data/data_source/edit_profile/edit_profile_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:EditProfileRemoteDataSource)
class EditProfileRemoteDataSourceImp implements EditProfileRemoteDataSource {
  final ApiClient apiClient;
  EditProfileRemoteDataSourceImp(this.apiClient);
  @override
  Future<Result<DriverDataEntity>> editProfile(EditProfileRequestModel request) {
    return executeApi(()async {
      final result = await apiClient.editProfile(
        token: "Bearer ${FloweryDriverMethodHelper.currentUserToken}",
        request: request,
      );
      final entity = result.toDriverDataEntity();
      FloweryDriverMethodHelper.driverData = entity;
      return entity;
    },);
  }
  }