
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';

sealed class ResetPasswordIntent {}
class InitializeResetPasswordFormIntent
    extends ResetPasswordIntent {}

class OnResetPasswordIntent extends ResetPasswordIntent {
  ResetPasswordRequestEntity request;

  OnResetPasswordIntent({required this.request});
}

