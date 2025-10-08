import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';

final class OrdersState extends Equatable {
  final StateStatus<List<OrderEntity>> driverOrdersStatus;
  final String completedOrders;
  final String canceledOrders;

  const OrdersState({
    this.driverOrdersStatus = const StateStatus.initial(),
    this.completedOrders = "0",
    this.canceledOrders = "0",
  });

  OrdersState copyWith({
    StateStatus<List<OrderEntity>>? driverOrdersStatus,
    String? completedOrders,
    String? canceledOrders,
  }) {
    return OrdersState(
      driverOrdersStatus: driverOrdersStatus ?? this.driverOrdersStatus,
      completedOrders: completedOrders ?? this.completedOrders,
      canceledOrders: canceledOrders ?? this.canceledOrders,
    );
  }

  @override
  List<Object?> get props => [
    driverOrdersStatus,
    completedOrders,
    canceledOrders,
  ];
}
