import 'package:equatable/equatable.dart';

class ShippingAddressEntity extends Equatable {
  final String? street;
  final String? city;
  final String? phone;
  final String? lat;
  final String? long;

  const ShippingAddressEntity({
    this.street,
    this.city,
    this.phone,
    this.lat,
    this.long,
  });

  @override
  List<Object?> get props => [street, city, phone, lat, long];
}
