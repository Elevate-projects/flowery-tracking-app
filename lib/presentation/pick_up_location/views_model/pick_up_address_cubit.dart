import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flowery_tracking_app/core/services/location_service.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views_model/pick_up_address_intent.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views_model/pick_up_address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class PickUpAddressCubit extends Cubit<PickupAddressState> {
  final LocationService _locationService;

  final MapController mapController = MapController();
  StreamSubscription<Position>? _locationSubscription;
  LatLng? _userLocation;

  PickUpAddressCubit(this._locationService)
    : super(const PickupAddressState(currentZoom: 15));

  Future<void> doIntent(PickupAddressIntent intent) async {
    switch (intent) {
      case PickupAddressInitIntent():
        _handleInit(
          userLocation: LatLng(
            double.parse(intent.orderData.shippingAddress!.lat.toString()),
            double.parse(intent.orderData.shippingAddress!.long.toString()),
          ),
        );
        break;
    }
  }

  Future<void> _handleInit({required LatLng userLocation}) async {

    _userLocation = userLocation;

    emit(state.copyWith(userLocation: _userLocation));

    await _initDriverLocation();
    _listenToZoom();
  }

  Future<void> _initDriverLocation() async {
    final hasPermission = await _locationService.checkPermission();
    if (!hasPermission) {
      emit(state.copyWith(error: "Location permission denied or services disabled."));
      return;
    }

    final position = await _locationService.getCurrentLocation();
    if (position == null) {
      emit(state.copyWith(error: "Failed to get current location."));
      return;
    }

    final driver = LatLng(position.latitude, position.longitude);
    emit(state.copyWith(driverLocation: driver));
    mapController.move(driver, 15.0);

    if (_userLocation != null) {
      await _updatePolyline(driver, _userLocation!);
    }

     _locationSubscription = _locationService.getLocationStream()?.listen((pos) async {
      final driver = LatLng(pos.latitude, pos.longitude);
      emit(state.copyWith(driverLocation: driver));

       mapController.move(driver, state.currentZoom);

       if (_userLocation != null) {
        await _updatePolyline(driver, _userLocation!);
      }
    });
  }


  void _listenToZoom() {
    mapController.mapEventStream.listen((event) {
       final newZoom =
          mapController.camera.zoom;
      if ((state.currentZoom - newZoom).abs() > 0.01) {
        emit(state.copyWith(currentZoom: newZoom));
      }
    });
  }

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

        emit(state.copyWith(routePoints: coords));
      }
    } catch (e) {
      log('🚨 Route error: $e');
    }
  }  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
