import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';

abstract interface class CountryRepository {
  Future<Result<List<CountryEntity>>> getAllCountries();
}
