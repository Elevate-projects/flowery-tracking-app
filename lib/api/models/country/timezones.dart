class Timezones {
  Timezones({
    this.zoneName,
    this.gmtOffset,
    this.gmtOffsetName,
    this.abbreviation,
    this.tzName,
  });

  String? zoneName;
  num? gmtOffset;
  String? gmtOffsetName;
  String? abbreviation;
  String? tzName;

  Timezones.fromJson(dynamic json) {
    zoneName = json['zoneName'];
    gmtOffset = json['gmtOffset'];
    gmtOffsetName = json['gmtOffsetName'];
    abbreviation = json['abbreviation'];
    tzName = json['tzName'];
  }
}
