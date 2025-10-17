
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/country/country_repository.dart';
import 'package:flowery_tracking_app/domain/use_cases/country/get_all_countries_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_countries_use_case_test.mocks.dart';
@GenerateMocks([CountryRepository])
void main(){
  final mockGetAllCountries = MockCountryRepository();
  final getAllCountriesUseCase = GetAllCountriesUseCase(mockGetAllCountries);
  test('when getAllCountries is called, it should return a list of countries', () async {
    //Arrange
    const testCountries = [
      CountryEntity(countryName: 'Egypt', flag: '🇪🇬'),
      CountryEntity(countryName: 'United States', flag: '🇺🇸'),
      CountryEntity(countryName: 'Japan', flag: '🇯🇵'),
    ];
    final expectedResult = Success<List<CountryEntity>>(testCountries);
      provideDummy<Result<List<CountryEntity>>>(expectedResult);
     when(mockGetAllCountries.getAllCountries())
          .thenAnswer((_) async => expectedResult);
          //Act
    final result = await getAllCountriesUseCase.invoke();
    final successResult = result as Success<List<CountryEntity>>;
    //Assert
     expect(result, isA<Success<List<CountryEntity>>>());
      expect(successResult.data, testCountries);
      expect(successResult.data.length, 3);
      verify(mockGetAllCountries.getAllCountries()).called(1);
  });
}