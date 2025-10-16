import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/logout/remote_data_source/logout_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/repositories/logout/logout_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRepository)
class LogoutRepositoryImpl implements LogoutRepository {
  final LogoutRemoteDataSource _logoutRemoteDataSource;
  const LogoutRepositoryImpl(this._logoutRemoteDataSource);

  @override
  Future<Result<void>> logout() async {
    return await _logoutRemoteDataSource.logout();
  }
}
