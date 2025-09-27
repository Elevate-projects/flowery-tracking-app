import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/data/data_source/gemini/remote_data_source/gemini_remote_data_source.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: GeminiRemoteDataSource)
class GeminiRemoteDataSourceImpl implements GeminiRemoteDataSource {
  final ApiClient _apiClient;
   final String _apiKey = "AIzaSyAScadAl18dhlOH5CdpKKHr_XSXmzOddxA";

  GeminiRemoteDataSourceImpl(this._apiClient);

  @override
  Future<String> extractLicensePlate(String base64Image) async {
    final body = {
      "contents": [
        {
          "parts": [
            {"text": "Extract only the license plate number from this image."},
            {
              "inline_data": {
                "mime_type": "image/jpeg",
                "data": base64Image,
              }
            }
          ]
        }
      ]
    };

    final response = await _apiClient.generateLicensePlate(body, _apiKey);

    if (response.response.statusCode == 200) {
      final geminiResponse = response.data;
      return geminiResponse.candidates.first.content.parts.first.text.trim();
    } else {
      throw Exception("Gemini request failed: ${response.response.statusCode}");
    }
  }
}