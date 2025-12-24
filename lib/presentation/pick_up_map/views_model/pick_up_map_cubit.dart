import 'dart:async';
import 'dart:convert';

import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/core/services/location_service.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/update_driver_loc/update_driver_loc.dart';
import 'package:flowery_tracking_app/domain/use_cases/update_driver_location/update_driver_location_usecase.dart';
import 'package:flowery_tracking_app/presentation/pick_up_map/views_model/pick_up_map_intent.dart';
import 'package:flowery_tracking_app/presentation/pick_up_map/views_model/pick_up_map_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class PickUpMapCubit extends Cubit<PickUpMapState> {
  PickUpMapCubit(this._updateDriverLocationUseCase, this._locationService)
    : super(const PickUpMapState());

  late final MapController mapController;
  StreamSubscription<Position>? _locationSubscription;
  final GetUpdateDriverLocationUseCase _updateDriverLocationUseCase;
  final LocationService _locationService;

  Future<void> doIntent({required PickUpMapIntent intent}) async {
    switch (intent) {
      case PickUpMapInitializationIntent():
        await _onInit(orderData: intent.orderData);
      case RecenterCameraOnDriverIntent():
        _recenterCameraOnDriver();
    }
  }

  Future<void> _onInit({required OrderEntity orderData}) async {
    emit(state.copyWith(orderData: orderData));
    mapController = MapController();
    await _initDriverLocation();
  }

  Future<void> _initDriverLocation() async {
    emit(state.copyWith(mapStatus: const StateStatus.loading()));
    final failure = await _locationService.checkAvailability();
    if (failure != null) {
      emit(
        state.copyWith(
          mapStatus: StateStatus.failure(failure.responseException),
        ),
      );
      emit(state.copyWith(mapStatus: const StateStatus.initial()));
      return;
    }
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      ),
    );

    final driver = LatLng(position.latitude, position.longitude);

    await _updateDriverLocationInFirebase(driver);

    emit(state.copyWith(driverLocation: driver));
    await _updatePolyline(driver, state.storeLocation);
    emit(state.copyWith(mapStatus: const StateStatus.success(null)));

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

          emit(state.copyWith(driverLocation: newDriver));

          await _updatePolyline(newDriver, state.storeLocation);
        });
  }

  Future<void> _updateDriverLocationInFirebase(LatLng driverLocation) async {
    final entity = UpdateDriverLocationEntity(
      orderId: state.orderData?.id ?? "",
      lat: driverLocation.latitude,
      long: driverLocation.longitude,
    );
    final result = await _updateDriverLocationUseCase.execute(entity);
    switch (result) {
      case Success<void>():
        break;
      case Failure<void>():
        emit(
          state.copyWith(
            mapStatus: StateStatus.failure(result.responseException),
          ),
        );
        emit(state.copyWith(mapStatus: const StateStatus.initial()));
        break;
    }
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

        emit(state.copyWith(polylinePoints: coords));
      }
    } catch (error) {
      emit(
        state.copyWith(
          mapStatus: StateStatus.failure(
            ResponseException(message: "Route error: $error"),
          ),
        ),
      );
      emit(state.copyWith(mapStatus: const StateStatus.initial()));
    }
  }

  void _recenterCameraOnDriver() {
    final driver = state.driverLocation;

    if ((driver.latitude == 0 && driver.longitude == 0) ||
        state.mapStatus.isLoading) {
      return;
    }

    mapController.move(driver, 17);
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
