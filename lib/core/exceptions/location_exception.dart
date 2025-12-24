import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';

class LocationException<T> extends Failure<T> {
  LocationException({required super.responseException});

  /// Helpers (named constructors)
  factory LocationException.serviceDisabled() {
    return LocationException(
      responseException: const ResponseException(
        message: 'Location service is disabled',
      ),
    );
  }

  factory LocationException.permissionDenied() {
    return LocationException(
      responseException: const ResponseException(
        message: 'Location permission denied',
      ),
    );
  }

  factory LocationException.permissionDeniedForever() {
    return LocationException(
      responseException: const ResponseException(
        message: 'Location permission permanently denied',
      ),
    );
  }

  factory LocationException.timeout() {
    return LocationException(
      responseException: const ResponseException(
        message: 'Location request timed out',
      ),
    );
  }

  factory LocationException.unknown(Object e) {
    return LocationException(
      responseException: ResponseException(message: e.toString()),
    );
  }
}
