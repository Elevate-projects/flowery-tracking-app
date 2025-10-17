import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/data_source/country/local_data_source/country_local_data_source_impl.dart';
import 'package:flowery_tracking_app/core/constants/json_files.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fake_asset_bandle.dart';

void main(){
  test('when fetching countries, then return a list of countries', ()async{
      // Arrange

     const mockJson = '''
      [
        {"name": "Afghanistan", "flag": "🇦🇫"},
        {"name": "Aland Islands", "flag": "🇦🇽"},
        {"name": "Albania", "flag": "🇦🇱"}
      ]
      ''';
        final fakeAssetBundle = FakeAssetBundle({
        JsonFiles.countries: mockJson,
      });
       final dataSource = CountryLocalDataSourceImpl(assetBundle: fakeAssetBundle);

    // Act
    final result = await dataSource.getAllCountries();
    final successResult= result as Success<List<CountryEntity>>;

    // Assert
    expect(result, isA<Success<List<CountryEntity>>>());
     expect(successResult.data.length, 3);
      
      expect(successResult.data[0].countryName, 'Afghanistan');
      expect(successResult.data[0].flag, '🇦🇫');
      
      expect(successResult.data[1].countryName, 'Aland Islands');
      expect(successResult.data[1].flag, '🇦🇽');

      expect(successResult.data[2].countryName, 'Albania');
      expect(successResult.data[2].flag, '🇦🇱');
  });
}