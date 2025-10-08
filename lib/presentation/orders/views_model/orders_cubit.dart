import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/completed_driver_orders/completed_driver_orders_use_case.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_intent.dart';
import 'package:flowery_tracking_app/presentation/orders/views_model/orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  final CompletedDriverOrdersUseCase _completedDriverOrdersUseCase;
  OrdersCubit(this._completedDriverOrdersUseCase) : super(const OrdersState());

  Future<void> doIntent({required OrdersIntent intent}) async {
    switch (intent) {
      case OrdersInitializationIntent():
        await _fetchDriverOrders();
        break;
    }
  }

  Future<void> _fetchDriverOrders() async {
    emit(state.copyWith(driverOrdersStatus: const StateStatus.loading()));
    final result = await _completedDriverOrdersUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<List<OrderEntity>>():
        final completedOrders = _getCompletedOrders(orders: result.data);
        final canceledOrders = _getCanceledOrders(orders: result.data);
        emit(
          state.copyWith(
            driverOrdersStatus: StateStatus.success(result.data),
            completedOrders: completedOrders,
            canceledOrders: canceledOrders,
          ),
        );
        break;
      case Failure<List<OrderEntity>>():
        emit(
          state.copyWith(
            driverOrdersStatus: StateStatus.failure(result.responseException),
          ),
        );
        break;
    }
  }

  String _getCompletedOrders({required List<OrderEntity>? orders}) {
    final completedOrders = orders
        ?.where(
          (orderData) =>
              orderData.state == CurrentOrderState.deliveredToTheUser.name,
        )
        .toList()
        .length;
    return completedOrders?.toString() ?? "0";
  }

  String _getCanceledOrders({required List<OrderEntity>? orders}) {
    final canceledOrders = orders
        ?.where(
          (orderData) =>
              orderData.state != CurrentOrderState.deliveredToTheUser.name,
        )
        .toList()
        .length;
    return canceledOrders?.toString() ?? "0";
  }
}
