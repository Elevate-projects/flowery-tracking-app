import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

enum LocationPermissionResult {
  granted,
  serviceDisabled,
  denied,
  permanentlyDenied,
}

@lazySingleton
class LocationService {
  Future<LocationPermissionResult> checkPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationPermissionResult.serviceDisabled;
    }
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationPermissionResult.denied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationPermissionResult.permanentlyDenied;
    }

    return LocationPermissionResult.granted;
  }

  Future<Position?> getCurrentLocation() async {
    final permissionResult = await checkPermission();
    if (permissionResult != LocationPermissionResult.granted) return null;

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Stream<Position> getLocationStream() {
    final locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );

    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}
