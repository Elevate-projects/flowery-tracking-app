import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';

abstract interface class CountryLocalDataSource {
  Future<Result<List<CountryEntity>>> getAllCountries();
}
