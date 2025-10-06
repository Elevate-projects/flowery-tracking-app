import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';

abstract class FloweryDriverMethodHelper {
  static DriverDataEntity? driverData;
  static String? currentDriverOrderId;
  static String? currentUserToken;

  static String getCurrentOrderStateText({required String currentOrderState}) {
    if (CurrentOrderState.inProgress.name == currentOrderState) {
      return AppText.accepted.tr();
    } else if (CurrentOrderState.arrivedAtPickupPoint.name ==
        currentOrderState) {
      return AppText.picked.tr();
    } else if (CurrentOrderState.startDeliver.name == currentOrderState) {
      return AppText.outForDelivery.tr();
    } else if (CurrentOrderState.arrivedToTheUser.name == currentOrderState) {
      return AppText.arrived.tr();
    } else {
      return AppText.delivered.tr();
    }
  }

  static CurrentOrderState getCurrentOrderState({
    required String currentOrderState,
  }) {
    if (CurrentOrderState.inProgress.name == currentOrderState) {
      return CurrentOrderState.inProgress;
    } else if (CurrentOrderState.arrivedAtPickupPoint.name ==
        currentOrderState) {
      return CurrentOrderState.arrivedAtPickupPoint;
    } else if (CurrentOrderState.startDeliver.name == currentOrderState) {
      return CurrentOrderState.startDeliver;
    } else if (CurrentOrderState.arrivedToTheUser.name == currentOrderState) {
      return CurrentOrderState.arrivedToTheUser;
    } else {
      return CurrentOrderState.deliveredToTheUser;
    }
  }

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
