import 'package:flowery_tracking_app/domain/entities/gemini/license_plate_entity.dart';

abstract class GeminiRepository {
  Future<LicensePlateEntity> extractLicensePlate(String base64Image);
}