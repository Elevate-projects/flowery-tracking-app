import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/constants/app_collections.dart';
import 'package:flowery_tracking_app/data/data_source/update_driver_location/update_driver_location_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/update_driver_loc/update_driver_loc.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UpdateDriverLocationDataSource)
class UpdateDiverLocationImpl implements UpdateDriverLocationDataSource {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<Result<void>> updateDriverLocation(
    UpdateDriverLocationEntity request,
  ) async {
    return await executeApi(() async {
      await _fireStore
          .collection(AppCollections.orders)
          .doc(request.orderId)
          .update({
            "DriverLatitude": request.lat,
            "DriverLongitude": request.long,
          });
    });
  }
}
