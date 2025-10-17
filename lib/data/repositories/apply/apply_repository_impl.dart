import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/apply/remote_data_source/apply_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/requests/apply_request/apply_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/apply/apply_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ApplyRepository)
class ApplyRepositoryImpl implements ApplyRepository {
  final ApplyRemoteDataSource _applyRemoteDataSource;
  const ApplyRepositoryImpl(this._applyRemoteDataSource);

  @override
  Future<Result<void>> apply({
    required ApplyRequestEntity applyRequestEntity,
  }) async {
    return await _applyRemoteDataSource.apply(
      applyRequestEntity: applyRequestEntity,
    );
  }
}
