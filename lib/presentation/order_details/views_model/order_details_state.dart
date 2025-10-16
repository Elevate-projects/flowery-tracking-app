import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';

final class OrderDetailsState extends Equatable {
  final StateStatus<OrderEntity> orderStatus;
  final StateStatus<void> updateOrderStateStatus;
  final StateStatus<void> openWhatsappStatus;
  final StateStatus<void> openPhoneStatus;
  final CurrentOrderState currentOrderState;
  final String selectedPhoneNumber;
  final String orderState;
  final String orderStateDate;
  final bool isOpeningWhatsapp;
  final bool isOpeningPhone;
  const OrderDetailsState({
    this.orderStatus = const StateStatus.initial(),
    this.updateOrderStateStatus = const StateStatus.initial(),
    this.openWhatsappStatus = const StateStatus.initial(),
    this.openPhoneStatus = const StateStatus.initial(),
    this.currentOrderState = CurrentOrderState.inProgress,
    this.orderState = AppText.accepted,
    this.orderStateDate = "",
    this.selectedPhoneNumber = "",
    this.isOpeningWhatsapp = false,
    this.isOpeningPhone = false,
  });

  OrderDetailsState copyWith({
    StateStatus<OrderEntity>? orderStatus,
    StateStatus<void>? updateOrderStateStatus,
    CurrentOrderState? currentOrderState,
    StateStatus<void>? openWhatsappStatus,
    StateStatus<void>? openPhoneStatus,
    String? selectedPhoneNumber,
    String? orderState,
    String? orderStateDate,
    bool? isOpeningWhatsapp,
    bool? isOpeningPhone,
  }) {
    return OrderDetailsState(
      orderStatus: orderStatus ?? this.orderStatus,
      updateOrderStateStatus:
          updateOrderStateStatus ?? this.updateOrderStateStatus,
      openWhatsappStatus: openWhatsappStatus ?? this.openWhatsappStatus,
      openPhoneStatus: openPhoneStatus ?? this.openPhoneStatus,
      currentOrderState: currentOrderState ?? this.currentOrderState,
      selectedPhoneNumber: selectedPhoneNumber ?? this.selectedPhoneNumber,
      orderState: orderState ?? this.orderState,
      orderStateDate: orderStateDate ?? this.orderStateDate,
      isOpeningWhatsapp: isOpeningWhatsapp ?? this.isOpeningWhatsapp,
      isOpeningPhone: isOpeningPhone ?? this.isOpeningPhone,
    );
  }

  @override
  List<Object?> get props => [
    orderStatus,
    currentOrderState,
    updateOrderStateStatus,
    openWhatsappStatus,
    openPhoneStatus,
    selectedPhoneNumber,
    orderState,
    orderStateDate,
    isOpeningWhatsapp,
    isOpeningPhone,
  ];
}
