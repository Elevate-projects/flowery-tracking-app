import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/login/remote_data_source/login_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/login/login_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _loginRemoteDataSource;
  const LoginRepositoryImpl(this._loginRemoteDataSource);

  @override
  Future<Result<void>> login({required LoginRequestEntity request}) async {
    return await _loginRemoteDataSource.login(request: request);
  }
}
