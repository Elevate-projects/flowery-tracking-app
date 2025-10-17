import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/country/local_data_source/country_local_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/country/country_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CountryRepository)
class CountryRepositoryImpl implements CountryRepository {
  final CountryLocalDataSource _countryLocalDataSource;
  const CountryRepositoryImpl(this._countryLocalDataSource);

  @override
  Future<Result<List<CountryEntity>>> getAllCountries() async {
    return await _countryLocalDataSource.getAllCountries();
  }
}
