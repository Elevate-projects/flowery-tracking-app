import 'package:flowery_tracking_app/api/client/api_result.dart';

abstract interface class LogoutRepository {
  Future<Result<void>> logout();
}
