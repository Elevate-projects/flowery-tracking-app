import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  const CountryEntity({required this.countryName, required this.flag});
  final String countryName;
  final String flag;
  @override
  List<Object?> get props => [countryName, flag];
}
