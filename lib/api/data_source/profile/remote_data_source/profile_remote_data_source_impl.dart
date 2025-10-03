import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/profile/remote_data_source/profile_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient _apiClient;

  ProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<DriverDataEntity?>> fetchUserData() async {
    return executeApi(() async {
      final response = await _apiClient.getUserData(
        token: "Bearer ${FloweryDriverMethodHelper.currentUserToken}",
      );
      return response.driver?.toDriverDataEntity();
    });
  }
}
