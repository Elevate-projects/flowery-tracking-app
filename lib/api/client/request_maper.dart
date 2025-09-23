import 'package:flowery_tracking_app/api/requests/login_request/login_request_model.dart';
import 'package:flowery_tracking_app/domain/entities/requests/login_request/login_request_entity.dart';

abstract class RequestMapper {
  static LoginRequestModel toLoginRequestModel({
    required LoginRequestEntity loginRequestEntity,
  }) {
    return LoginRequestModel(
      email: loginRequestEntity.email,
      password: loginRequestEntity.password,
    );
  }
}
