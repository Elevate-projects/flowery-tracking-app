import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';

final class OrderDetailsState extends Equatable {
  final StateStatus<OrderEntity> orderStatus;
  final StateStatus<void> updateOrderStateStatus;
  final StateStatus<void> openWhatsappStatus;
  final StateStatus<void> openPhoneStatus;
  final CurrentOrderState currentOrderState;
  final String selectedPhoneNumber;
  final bool isOpeningWhatsapp;
  final bool isOpeningPhone;
  const OrderDetailsState({
    this.orderStatus = const StateStatus.initial(),
    this.updateOrderStateStatus = const StateStatus.initial(),
    this.openWhatsappStatus = const StateStatus.initial(),
    this.openPhoneStatus = const StateStatus.initial(),
    this.currentOrderState = CurrentOrderState.inProgress,
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
    isOpeningWhatsapp,
    isOpeningPhone,
  ];
}
