import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shipping_address_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ShippingAddressModel {
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;

  ShippingAddressModel({
    this.street,
    this.city,
    this.phone,
    this.lat,
    this.long,
  });

  static ShippingAddressModel dummy() => ShippingAddressModel(
    phone: "+201116211489",
    city: "Cairo",
    street: "Saqr-koresh",
    lat: "29.98508582119217",
    long: "31.27334386662929",
  );

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return _$ShippingAddressModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ShippingAddressModelToJson(this);
  }

  ShippingAddressEntity toShippingAddressEntity() {
    return ShippingAddressEntity(
      street: street,
      city: city,
      phone: phone,
      lat: lat,
      long: long,
    );
  }
}
