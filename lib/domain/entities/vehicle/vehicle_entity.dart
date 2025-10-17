import 'package:equatable/equatable.dart';

class VehicleEntity extends Equatable {
  const VehicleEntity({required this.id, required this.type});

  final String id;
  final String type;

  @override
  List<Object?> get props => [id, type];
}
