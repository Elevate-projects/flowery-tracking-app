import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/api/requests/login_request/login_request_model.dart';
import 'package:flowery_tracking_app/api/responses/gemini_response/gemini_response.dart';
import 'package:flowery_tracking_app/api/responses/login_response/login_response.dart';
import 'package:flowery_tracking_app/api/responses/vehicles_response/vehicles_response.dart';
import 'package:flowery_tracking_app/core/constants/endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi(baseUrl: Endpoints.baseUrl)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(Endpoints.login)
  Future<LoginResponse> login({@Body() required LoginRequestModel request});

  @GET(Endpoints.vehicles)
  Future<VehiclesResponse> getAllVehicles();

  @POST(Endpoints.apply)
  @MultiPart()
  Future<void> apply(@Body() FormData applyRequestModel);


   // Gemini OCR endpoint
  @POST("/models/gemini-1.5-flash:generateContent")
  Future<HttpResponse<GeminiResponse>> generateLicensePlate(
    @Body() Map<String, dynamic> body,
    @Query("key") String apiKey,
  );
}
