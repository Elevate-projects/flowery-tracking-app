import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_mapper.dart';
import 'package:flowery_tracking_app/data/data_source/apply/remote_data_source/apply_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/requests/apply_request/apply_request_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ApplyRemoteDataSource)
class ApplyRemoteDataSourceImpl implements ApplyRemoteDataSource {
  final ApiClient _apiClient;
  const ApplyRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<void>> apply({
    required ApplyRequestEntity applyRequestEntity,
  }) async {
    return executeApi(() async {
      final applyRequestModel = RequestMapper.toApplyRequestModel(
        applyRequestEntity: applyRequestEntity,
      );
      final formData = await applyRequestModel.toFormData();
      return await _apiClient.apply(formData);
    });
  }
}
