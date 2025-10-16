import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_mapper.dart';
import 'package:flowery_tracking_app/data/data_source/edit_profile/edit_profile_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/entities/edit_profile/edit_profile_entity.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:EditProfileRemoteDataSource)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final ApiClient apiClient;
  EditProfileRemoteDataSourceImpl(this.apiClient);
  @override
  Future<Result<DriverDataEntity>> editProfile(EditProfileRequestEntity request)async {
    return executeApi(()async {
      final result = await apiClient.editProfile(
        request: RequestMapper.toEditProfileRequestModel(request: request),
        token: "Bearer ${FloweryDriverMethodHelper.currentUserToken}",
      );
      final entity = result.toDriverDataEntity();
      FloweryDriverMethodHelper.driverData = entity;
      return entity;
    },);
  }
  }