import 'package:flowery_tracking_app/data/data_source/gemini/remote_data_source/gemini_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/gemini/license_plate_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/gemini/gemini_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: GeminiRepository)
class GeminiRepositoryImpl implements GeminiRepository {
  final GeminiRemoteDataSource remoteDataSource;

  GeminiRepositoryImpl(this.remoteDataSource);

  @override
  Future<LicensePlateEntity> extractLicensePlate(String base64Image) async {
    final number = await remoteDataSource.extractLicensePlate(base64Image);
    return LicensePlateEntity(number);
  }
}