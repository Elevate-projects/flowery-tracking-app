import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:latlong2/latlong.dart';

final class PickUpMapState extends Equatable {
  final StateStatus<void> mapStatus;
  final LatLng driverLocation;
  final LatLng storeLocation;
  final List<LatLng> polylinePoints;
  final double currentZoom;
  final OrderEntity? orderData;

  const PickUpMapState({
    this.mapStatus = const StateStatus.initial(),
    this.driverLocation = const LatLng(0, 0),
    this.storeLocation = const LatLng(29.961230091318225, 31.25794485159479),
    this.polylinePoints = const [],
    this.currentZoom = 13,
    this.orderData,
  });

  PickUpMapState copyWith({
    StateStatus<void>? mapStatus,
    LatLng? driverLocation,
    LatLng? storeLocation,
    List<LatLng>? polylinePoints,
    double? currentZoom,
    OrderEntity? orderData,
  }) {
    return PickUpMapState(
      mapStatus: mapStatus ?? this.mapStatus,
      driverLocation: driverLocation ?? this.driverLocation,
      storeLocation: storeLocation ?? this.storeLocation,
      polylinePoints: polylinePoints ?? this.polylinePoints,
      currentZoom: currentZoom ?? this.currentZoom,
      orderData: orderData ?? this.orderData,
    );
  }

  @override
  List<Object?> get props => [
    mapStatus,
    driverLocation,
    storeLocation,
    polylinePoints,
    currentZoom,
    orderData,
  ];
}
