import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flowery_tracking_app/domain/entities/update_driver_loc/update_driver_loc.dart';
import 'package:flowery_tracking_app/domain/use_cases/update_driver_location/update_driver_location_usecase.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_intent.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class UserAddressMapCubit extends Cubit<UserAddressMapState> {
  final MapController mapController = MapController();
  StreamSubscription<Position>? _locationSubscription;
  final GetUpdateDriverLocationUseCase _updateDriverLocationUseCase;

  LatLng? _userLocation;
  String? _orderId;

  UserAddressMapCubit(this._updateDriverLocationUseCase)
    : super(const UserAddressMapState(currentZoom: 15));

  Future<void> doIntent(UserAddressMapIntent intent) {
    switch (intent) {
      case UserAddressMapInitializationIntent():
        return _initMap(
          userLocation: LatLng(
            double.parse(intent.orderData.shippingAddress!.lat.toString()),
            double.parse(intent.orderData.shippingAddress!.long.toString()),
          ),
          orderId: intent.orderData.id!,
        );
    }
  }

  Future<void> _initMap({
    required LatLng userLocation,
    required String orderId,
  }) async {
    _userLocation = userLocation;
    _orderId = orderId;

    emit(state.copyWith(userLocation: _userLocation));

    await _initDriverLocation();
    _listenToZoom();
  }

  Future<void> _initDriverLocation() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    // 🚗 Initial driver position
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      ),
    );

    final driver = LatLng(position.latitude, position.longitude);

    await _updateDriverLocationInFirebase(driver);

    emit(state.copyWith(driverLocation: driver));
    mapController.move(driver, 15.0);

    // Draw route to user
    if (_userLocation != null) {
      await _updatePolyline(driver, _userLocation!);
    }

    // 🔁 Live updates
    _locationSubscription =
        Geolocator.getPositionStream(
          locationSettings: AndroidSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            distanceFilter: 0,
            intervalDuration: const Duration(seconds: 3),
          ),
        ).listen((pos) async {
          final newDriver = LatLng(pos.latitude, pos.longitude);

          await _updateDriverLocationInFirebase(newDriver);
          log(
            '📍 [${DateTime.now().toIso8601String()}] Location SENT: $newDriver',
          );

          emit(state.copyWith(driverLocation: newDriver));

          mapController.move(newDriver, state.currentZoom);

          if (_userLocation != null) {
            await _updatePolyline(newDriver, _userLocation!);
          }
        });
  }

  Future<void> _updateDriverLocationInFirebase(LatLng driverLocation) async {
    try {
      final entity = UpdateDriverLocationEntity(
        orderId: _orderId!,
        lat: driverLocation.latitude,
        long: driverLocation.longitude,
      );
      await _updateDriverLocationUseCase.execute(entity);
    } catch (e) {
      log(' Firebase update error: $e');
    }
  }

  void _listenToZoom() {
    mapController.mapEventStream.listen((event) {
      // We listen to *any* event that affects the camera
      final newZoom =
          mapController.camera.zoom; // Only emit when zoom actually changes
      if ((state.currentZoom - newZoom).abs() > 0.01) {
        emit(state.copyWith(currentZoom: newZoom));
      }
    });
  }

  /// 🛣️ Draw route between driver and user
  Future<void> _updatePolyline(LatLng start, LatLng end) async {
    try {
      final url = Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/'
        '${start.longitude},${start.latitude};'
        '${end.longitude},${end.latitude}?overview=full&geometries=geojson',
      );

      final res = await http.get(url);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final coords = (data['routes']?[0]['geometry']['coordinates'] ?? [])
            .map<LatLng>((c) => LatLng(c[1], c[0]))
            .toList();

        emit(state.copyWith(polylinePoints: coords));
      }
    } catch (e) {
      log('🚨 Route error: $e');
    }
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
