import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';

enum CurrentOrderState {
  inProgress,
  arrivedAtPickupPoint,
  startDeliver,
  arrivedToTheUser,
  deliveredToTheUser,
  completed,
}

abstract class FloweryDriverMethodHelper {
  static DriverDataEntity? driverData;
  static String? currentDriverOrderId;
  static String? currentUserToken;

  static String getCurrentOrderStateButtonTitle({
    required String currentOrderState,
  }) {
    if (CurrentOrderState.inProgress.name == currentOrderState) {
      return AppText.arrivedAtPickupPoint.tr();
    } else if (CurrentOrderState.arrivedAtPickupPoint.name ==
        currentOrderState) {
      return AppText.startDeliver.tr();
    } else if (CurrentOrderState.startDeliver.name == currentOrderState) {
      return AppText.arrivedToTheUser.tr();
    } else if (CurrentOrderState.arrivedToTheUser.name == currentOrderState) {
      return AppText.deliveredToTheUser.tr();
    } else {
      return AppText.deliveredToTheUser.tr();
    }
  }
}
