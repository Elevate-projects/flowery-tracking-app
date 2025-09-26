import 'package:flowery_tracking_app/api/models/country/timezones.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';

class CountryModel {
  CountryModel({
    this.isoCode,
    this.name,
    this.phoneCode,
    this.flag,
    this.currency,
    this.latitude,
    this.longitude,
    this.timezones,
  });

  String? isoCode;
  String? name;
  String? phoneCode;
  String? flag;
  String? currency;
  String? latitude;
  String? longitude;
  List<Timezones>? timezones;

  CountryModel.fromJson(dynamic json) {
    isoCode = json['isoCode'];
    name = json['name'];
    phoneCode = json['phoneCode'];
    flag = json['flag'];
    currency = json['currency'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['timezones'] != null) {
      timezones = [];
      json['timezones'].forEach((v) {
        timezones?.add(Timezones.fromJson(v));
      });
    }
  }

  CountryEntity toCountryEntity() {
    return CountryEntity(countryName: name ?? "", flag: flag ?? "");
  }
}
