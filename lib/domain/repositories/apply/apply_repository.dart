import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/requests/apply_request/apply_request_entity.dart';

abstract interface class ApplyRepository {
  Future<Result<void>> apply({required ApplyRequestEntity applyRequestEntity});
}
