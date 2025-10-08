import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class UserAddressMapState extends Equatable {
  final LatLng? driverLocation;
  final LatLng? userLocation;
  final List<LatLng> polylinePoints;
  final double currentZoom;

  const UserAddressMapState({
    this.driverLocation,
    this.userLocation,
    this.polylinePoints = const [],
    this.currentZoom = 15,
  });

  UserAddressMapState copyWith({
    LatLng? driverLocation,
    LatLng? userLocation,
    List<LatLng>? polylinePoints,
    double? currentZoom,
  }) {
    return UserAddressMapState(
      driverLocation: driverLocation ?? this.driverLocation,
      userLocation: userLocation ?? this.userLocation,
      polylinePoints: polylinePoints ?? this.polylinePoints,
      currentZoom: currentZoom ?? this.currentZoom,
    );
  }

  @override
  List<Object?> get props => [
    driverLocation,
    userLocation,
    polylinePoints,
    currentZoom,
  ];
}
