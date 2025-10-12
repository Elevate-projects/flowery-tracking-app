import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/repositories/logout/logout_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final LogoutRepository _logoutRepository;
  const LogoutUseCase(this._logoutRepository);

  Future<Result<void>> invoke() async {
    return await _logoutRepository.logout();
  }
}
