import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/requests/login_request/login_request_entity.dart';

abstract interface class LoginRemoteDataSource {
  Future<Result<void>> login({required LoginRequestEntity request});
}
