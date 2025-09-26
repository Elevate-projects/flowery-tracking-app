import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/requests/apply_request/apply_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/apply/apply_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplyUseCase {
  final ApplyRepository _applyRepository;
  const ApplyUseCase(this._applyRepository);

  Future<Result<void>> invoke({required ApplyRequestEntity request}) async {
    return await _applyRepository.apply(applyRequestEntity: request);
  }
}
