import 'package:flowery_tracking_app/domain/entities/gemini/license_plate_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/gemini/gemini_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class GeminiUseCase {
  final GeminiRepository repository;

  GeminiUseCase(this.repository);

  Future<LicensePlateEntity> extractLicensePlate(String base64Image) {
    return repository.extractLicensePlate(base64Image);
  }
}