import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/country/local_data_source/country_local_data_source.dart';
import 'package:flowery_tracking_app/data/repositories/country/country_repository_impl.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'country_repository_impl_test.mocks.dart';
@GenerateMocks([CountryLocalDataSource])
void main(){
final mockCountryLocalDataSource = MockCountryLocalDataSource();
final countryRepositoryImpl = CountryRepositoryImpl(mockCountryLocalDataSource);


    test('when calling getCountries, it should return a list of countries', () async {
      //Arrange
        const testCountries = [
      CountryEntity(countryName: 'Egypt', flag: '🇪🇬'),
      CountryEntity(countryName: 'United States', flag: '🇺🇸'),
      CountryEntity(countryName: 'Japan', flag: '🇯🇵'),
    ];
    final expectedResult = Success<List<CountryEntity>>(testCountries);
    provideDummy<Result<List<CountryEntity>>>(expectedResult);
     when(mockCountryLocalDataSource.getAllCountries())
          .thenAnswer((_) async => expectedResult);
          //Act
    final result = await countryRepositoryImpl.getAllCountries();
    final successResult =result as Success<List<CountryEntity>>;
    //Assert
     expect(result, isA<Success<List<CountryEntity>>>());
      expect(successResult.data, testCountries);
      expect(successResult.data.length, 3);
      verify(mockCountryLocalDataSource.getAllCountries()).called(1);
    });
}