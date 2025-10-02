import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/accept_order/accept_order_request_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/accept_order/accept_order_use_case.dart';
import 'package:flowery_tracking_app/domain/use_cases/fetch_driver_pending_orders/fetch_driver_pending_orders_use_case.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_intent.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final FetchDriverPendingOrdersUseCase _fetchDriverPendingOrdersUseCase;
  final AcceptOrderUseCase _acceptOrderUseCase;
  HomeCubit(this._fetchDriverPendingOrdersUseCase, this._acceptOrderUseCase)
    : super(const HomeState());

  Future<void> doIntent({required HomeIntent intent}) async {
    switch (intent) {
      case HomeInitializationIntent():
        await _onInit();
        break;
      case FetchDriverPendingOrdersIntent():
        await _fetchDriverPendingOrders(isReloaded: true);
        break;
      case AcceptOrderIntent():
        await _acceptOrder(request: intent.request);
        break;
      case RejectOrderIntent():
        _rejectOrder(orderId: intent.orderId);
        break;
    }
  }

  Future<void> _onInit() async {
    await _fetchDriverPendingOrders(isReloaded: false);
  }

  Future<void> _fetchDriverPendingOrders({required bool isReloaded}) async {
    emit(state.copyWith(pendingOrdersStatus: const StateStatus.loading()));
    final result = await _fetchDriverPendingOrdersUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<List<OrderEntity>>():
        emit(
          state.copyWith(
            pendingOrdersStatus: StateStatus.success(result.data),
            isReloading: isReloaded,
          ),
        );
        emit(state.copyWith(isReloading: false));
        break;
      case Failure<List<OrderEntity>>():
        emit(
          state.copyWith(
            pendingOrdersStatus: StateStatus.failure(result.responseException),
          ),
        );
        break;
    }
  }

  Future<void> _acceptOrder({required AcceptOrderRequestEntity request}) async {
    emit(
      state.copyWith(
        acceptOrderStatus: const StateStatus.loading(),
        currentOrderID: request.orderId,
      ),
    );
    final result = await _acceptOrderUseCase.invoke(request: request);
    if (isClosed) return;
    switch (result) {
      case Success<void>():
        emit(
          state.copyWith(
            acceptOrderStatus: const StateStatus.success(null),
            currentOrderID: "",
          ),
        );
        emit(state.copyWith(acceptOrderStatus: const StateStatus.initial()));
        break;
      case Failure<void>():
        emit(
          state.copyWith(
            acceptOrderStatus: StateStatus.failure(result.responseException),
            currentOrderID: "",
          ),
        );
        emit(state.copyWith(acceptOrderStatus: const StateStatus.initial()));
        break;
    }
  }

  void _rejectOrder({required String orderId}) {
    state.pendingOrdersStatus.data?.removeWhere((order) => order.id == orderId);
    emit(
      state.copyWith(
        pendingOrdersStatus: StateStatus.success(
          state.pendingOrdersStatus.data ?? [],
        ),
      ),
    );
  }
}
