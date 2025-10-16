import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';

final class HomeState extends Equatable {
  final StateStatus<List<OrderEntity>> pendingOrdersStatus;
  final StateStatus<void> acceptOrderStatus;
  final String currentOrderID;
  final bool isReloading;
  const HomeState({
    this.pendingOrdersStatus = const StateStatus.initial(),
    this.acceptOrderStatus = const StateStatus.initial(),
    this.currentOrderID = "",
    this.isReloading = false,
  });
  HomeState copyWith({
    StateStatus<List<OrderEntity>>? pendingOrdersStatus,
    StateStatus<void>? acceptOrderStatus,
    String? currentOrderID,
    bool? isReloading,
  }) {
    return HomeState(
      pendingOrdersStatus: pendingOrdersStatus ?? this.pendingOrdersStatus,
      acceptOrderStatus: acceptOrderStatus ?? this.acceptOrderStatus,
      currentOrderID: currentOrderID ?? this.currentOrderID,
      isReloading: isReloading ?? this.isReloading,
    );
  }

  @override
  List<Object?> get props => [
    pendingOrdersStatus,
    acceptOrderStatus,
    currentOrderID,
    isReloading,
  ];
}
