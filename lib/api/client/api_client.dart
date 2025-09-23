import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/api/requests/forget_password_and_resend_code/forget_password_and_resend_code_request_model.dart';
import 'package:flowery_tracking_app/api/requests/reset_password/reset_password_request_model.dart';
import 'package:flowery_tracking_app/api/requests/verification/verify_request_model.dart';
import 'package:flowery_tracking_app/api/responses/forget_password_and_resend_code/forget_password_and_resend_code_response.dart';
import 'package:flowery_tracking_app/api/responses/reset_password/reset_password_response.dart';
import 'package:flowery_tracking_app/api/responses/verification/verify_response.dart';
import 'package:flowery_tracking_app/core/constants/endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi(baseUrl: Endpoints.baseUrl)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(Endpoints.forgetPasswordAndResendCode)
  Future<ForgetPasswordAndResendCodeResponse> forgetPasswordAndResendCode(
    @Body() ForgetPasswordAndResendCodeRequestModel request,
  );

  @POST(Endpoints.verification)
  Future<VerifyResponse> verificationCode(@Body() VerifyRequestModel request);

  @PUT(Endpoints.resetPassword)
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequestModel request,
  );
}
