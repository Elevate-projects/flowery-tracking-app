import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/country/country_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCountriesUseCase {
  final CountryRepository _countryRepository;
  const GetAllCountriesUseCase(this._countryRepository);

  Future<Result<List<CountryEntity>>> invoke() async {
    return await _countryRepository.getAllCountries();
  }
}
