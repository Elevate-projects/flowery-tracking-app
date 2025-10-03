import 'dart:convert';

import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/models/country/country_model.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/constants/json_files.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/data/data_source/country/local_data_source/country_local_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CountryLocalDataSource)
class CountryLocalDataSourceImpl implements CountryLocalDataSource {
  final AssetBundle assetBundle;

  CountryLocalDataSourceImpl({AssetBundle? assetBundle})
      : assetBundle = assetBundle ?? rootBundle;
  @override
  Future<Result<List<CountryEntity>>> getAllCountries() async {
    try {
      final jsonString = await assetBundle.loadString(JsonFiles.countries);
      final List<dynamic> data = json.decode(jsonString) as List<dynamic>;
      final List<CountryEntity> countries = data
          .map((json) => CountryModel.fromJson(json).toCountryEntity())
          .toList();
      return Success<List<CountryEntity>>(countries);
    } catch (error) {
      return Failure(
        responseException: const ResponseException(
          message: AppText.loadingCountriesFailureMessage,
        ),
      );
    }
  }
}
