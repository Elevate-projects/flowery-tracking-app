import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_mapper.dart';
import 'package:flowery_tracking_app/api/responses/forget_password_and_resend_code/forget_password_and_resend_code_response.dart';
import 'package:flowery_tracking_app/data/data_source/forget_password_and_resend_code/forget_password_and_resend_code_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordAndResendCodeDataSource)
class ForgetPasswordAndResendCodeDataSourceImpl
    implements ForgetPasswordAndResendCodeDataSource {
  final ApiClient _apiClient;

  const ForgetPasswordAndResendCodeDataSourceImpl(this._apiClient);

  @override
  Future<Result<ForgetPasswordAndResendCodeResponse>> resendCode(
    ForgetPasswordAndResendCodeRequestEntity request,
  ) async {
    return executeApi(() async {
      final res = await _apiClient.forgetPasswordAndResendCode(
        RequestMapper.toForgetPasswordAndResendCodeRequestModel(
          forgetPasswordRequestEntity: request,
        ),
      );
      return res;
    });
  }
}
