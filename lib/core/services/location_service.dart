import 'dart:async';

import 'package:flowery_tracking_app/core/exceptions/location_exception.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationService {
  const LocationService();

  Future<LocationException<void>?> checkAvailability() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationException.serviceDisabled();
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationException.permissionDenied();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationException.permissionDeniedForever();
    }

    return null;
  }

  LocationException<void> mapException(Object e) {
    if (e is TimeoutException) {
      return LocationException.timeout();
    }

    return LocationException.unknown(e);
  }
}
