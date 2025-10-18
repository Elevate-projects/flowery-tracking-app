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
  LatLng? _storeLocation;
  LatLng? _driverLocation;
  Position? _lastPolylineUpdatePosition;
  DateTime _lastPolylineUpdateTime = DateTime.now();

  PickUpAddressCubit(this._locationService)
    : super(const PickupAddressState(currentZoom: 15));

  Future<void> doIntent(PickupAddressIntent intent) async {
    switch (intent) {
      case PickupAddressInitIntent():
      await _handleInit(
        storeLocation: LatLng(
            double.parse(intent.orderData.shippingAddress!.lat.toString()),
            double.parse(intent.orderData.shippingAddress!.long.toString()),
          ),
        );
        break;
    }
  }

  Future<void> _handleInit({required LatLng storeLocation}) async {

    _storeLocation = storeLocation;

    emit(state.copyWith(storeLocation: _storeLocation));

    await _initDriverLocation();
    _listenToZoom();
  }

  Future<void> _initDriverLocation() async {
    final permissionResult = await _locationService.checkPermission();
    if (permissionResult != LocationPermissionResult.granted) {
      emit(state.copyWith(error: "Location permission denied or services disabled."));
      return;
    }

    final position = await _locationService.getCurrentLocation();
    if (position == null) {
      emit(state.copyWith(error: "Failed to get current location."));
      return;
    }

    _driverLocation  = LatLng(position.latitude, position.longitude);
    emit(state.copyWith(driverLocation: _driverLocation ));
    mapController.move(_driverLocation!, 15.0);

    if (_storeLocation != null) {
      await _updatePolyline(_driverLocation!, _storeLocation!);
    }

     _locationSubscription = _locationService.getLocationStream().listen((pos) async {
       _driverLocation = LatLng(pos.latitude, pos.longitude);
      emit(state.copyWith(driverLocation: _driverLocation));

       mapController.move(_driverLocation!, state.currentZoom);

       if (_storeLocation  != null) {
         final distanceMoved = _lastPolylineUpdatePosition == null
             ? double.infinity
             : Geolocator.distanceBetween(
           _lastPolylineUpdatePosition!.latitude,
           _lastPolylineUpdatePosition!.longitude,
           pos.latitude,
           pos.longitude,
         );
         final secondsSinceLast = DateTime.now().difference(_lastPolylineUpdateTime).inSeconds;
         if (distanceMoved > 50 || secondsSinceLast > 10) {
           await _updatePolyline(_driverLocation!, _storeLocation!);
           _lastPolylineUpdatePosition = pos;
           _lastPolylineUpdateTime = DateTime.now();
         }
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
