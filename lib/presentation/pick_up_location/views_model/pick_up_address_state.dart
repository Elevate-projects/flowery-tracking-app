import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

final class PickupAddressState extends Equatable {
  final LatLng? driverLocation;
  final LatLng? userLocation;
  final List<LatLng> routePoints;
  final double currentZoom;
  final String? error;

  const PickupAddressState({
    this.driverLocation,
    this.userLocation,
    this.routePoints = const [],
    this.currentZoom = 15,
    this.error,
  });

  PickupAddressState copyWith({
    LatLng? driverLocation,
    LatLng? userLocation,
    List<LatLng>? routePoints,
    double? currentZoom,
    String? error,
  }) {
    return PickupAddressState(
      driverLocation: driverLocation ?? this.driverLocation,
      userLocation: userLocation ?? this.userLocation,
      routePoints: routePoints ?? this.routePoints,
      currentZoom: currentZoom ?? this.currentZoom,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    driverLocation,
    userLocation,
    routePoints,
    currentZoom,
    error, // Add error to props for Equatable
  ];
}