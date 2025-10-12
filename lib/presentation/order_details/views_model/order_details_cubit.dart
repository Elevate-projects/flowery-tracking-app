import 'dart:async';

import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/cache/shared_preferences_helper.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/order_details/update_order_status_request_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/fetch_current_driver_order/fetch_current_driver_order_use_case.dart';
import 'package:flowery_tracking_app/domain/use_cases/update_order_status/update_order_status_use_case.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_intent.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final FetchCurrentDriverOrderUseCase _fetchCurrentDriverOrderUseCase;
  final UpdateOrderStatusUseCase _updateOrderStatusUseCase;
  final SharedPreferencesHelper _sharedPreferencesHelper;
  OrderDetailsCubit(
    this._fetchCurrentDriverOrderUseCase,
    this._updateOrderStatusUseCase,
    this._sharedPreferencesHelper,
  ) : super(const OrderDetailsState());

  late final bool isArLanguage;
  StreamSubscription<Result<OrderEntity>>? _driverOrderSubscription;

  Future<void> doIntent({required OrderDetailsIntent intent}) async {
    switch (intent) {
      case OrderDetailsInitializationIntent():
        await _onInit();
        break;
      case UpdateOrderStateIntent():
        await _updateOrderState();
        break;
      case OpenWhatsAppIntent():
        await _openWhatsApp(phone: intent.phoneNumber);
        break;
      case OpenPhoneIntent():
        await _openPhoneDialer(phone: intent.phoneNumber);
        break;
    }
  }

  Future<void> _onInit() async {
    isArLanguage = _sharedPreferencesHelper.getBool(
      key: ConstKeys.isArLanguage,
    );
    _fetchDriverOrder();
  }

  void _fetchDriverOrder() {
    emit(state.copyWith(orderStatus: const StateStatus.loading()));
    _driverOrderSubscription = _fetchCurrentDriverOrderUseCase
        .invoke(orderId: FloweryDriverMethodHelper.currentDriverOrderId ?? "")
        .listen((driverOrder) {
          switch (driverOrder) {
            case Success<OrderEntity>():
              {
                final orderState = _getCurrentOrderState(
                  orderData: driverOrder.data,
                );
                emit(
                  state.copyWith(
                    orderStatus: StateStatus.success(driverOrder.data),
                    currentOrderState: orderState,
                  ),
                );
              }
              break;
            case Failure<OrderEntity>():
              emit(
                state.copyWith(
                  orderStatus: StateStatus.failure(
                    driverOrder.responseException,
                  ),
                ),
              );
              emit(state.copyWith(orderStatus: const StateStatus.initial()));
              break;
          }
        });
  }

  Future<void> _updateOrderState() async {
    emit(state.copyWith(updateOrderStateStatus: const StateStatus.loading()));
    final nextOrderState = _getNextOrderState(
      currentOrderState: state.currentOrderState,
    );
    final result = await _updateOrderStatusUseCase.invoke(
      request: UpdateOrderStatusRequestEntity(
        orderId: state.orderStatus.data?.id ?? "",
        orderStatus: nextOrderState.name,
      ),
    );
    if (isClosed) return;
    switch (result) {
      case Success<void>():
        emit(
          state.copyWith(
            updateOrderStateStatus: const StateStatus.success(null),
            currentOrderState: nextOrderState,
          ),
        );
        break;
      case Failure<void>():
        emit(
          state.copyWith(
            updateOrderStateStatus: StateStatus.failure(
              result.responseException,
            ),
          ),
        );
        emit(
          state.copyWith(updateOrderStateStatus: const StateStatus.initial()),
        );
        break;
    }
  }

  CurrentOrderState _getNextOrderState({
    required CurrentOrderState currentOrderState,
  }) {
    late final CurrentOrderState nextOrderState;
    if (currentOrderState.name != CurrentOrderState.completed.name) {
      nextOrderState = CurrentOrderState
          .values[CurrentOrderState.values.indexOf(currentOrderState) + 1];
    } else {
      nextOrderState = CurrentOrderState.completed;
    }
    return nextOrderState;
  }

  Future<void> _openWhatsApp({required String phone}) async {
    final whatsappUri = Uri.parse('whatsapp://send?phone=$phone${''}');
    final waMeUri = Uri.parse('https://wa.me/$phone${''}');

    try {
      emit(
        state.copyWith(
          openWhatsappStatus: const StateStatus.loading(),
          isOpeningWhatsapp: true,
          selectedPhoneNumber: phone,
        ),
      );
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
        emit(
          state.copyWith(
            openWhatsappStatus: const StateStatus.success(null),
            isOpeningWhatsapp: false,
            selectedPhoneNumber: "",
          ),
        );
        return;
      }

      if (await canLaunchUrl(waMeUri)) {
        await launchUrl(waMeUri, mode: LaunchMode.externalApplication);
        emit(
          state.copyWith(
            openWhatsappStatus: const StateStatus.success(null),
            isOpeningWhatsapp: false,
            selectedPhoneNumber: "",
          ),
        );
        return;
      }
    } catch (e) {
      emit(
        state.copyWith(
          openWhatsappStatus: const StateStatus.failure(
            ResponseException(message: AppText.openWhatsappFailureMessage),
          ),
        ),
      );
      emit(
        state.copyWith(
          openWhatsappStatus: const StateStatus.initial(),
          isOpeningWhatsapp: false,
          selectedPhoneNumber: "",
        ),
      );
    }
  }

  Future<void> _openPhoneDialer({required String phone}) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);

    try {
      emit(
        state.copyWith(
          openPhoneStatus: const StateStatus.loading(),
          isOpeningPhone: true,
          selectedPhoneNumber: phone,
        ),
      );
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
        emit(
          state.copyWith(
            openPhoneStatus: const StateStatus.success(null),
            isOpeningPhone: false,
            selectedPhoneNumber: "",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          openPhoneStatus: const StateStatus.failure(
            ResponseException(message: AppText.openPhoneFailureMessage),
          ),
        ),
      );
      emit(
        state.copyWith(
          openPhoneStatus: const StateStatus.initial(),
          isOpeningPhone: false,
          selectedPhoneNumber: "",
        ),
      );
    }
  }

  CurrentOrderState _getCurrentOrderState({required OrderEntity orderData}) {
    if (CurrentOrderState.inProgress.name == orderData.state) {
      emit(
        state.copyWith(
          orderState: AppText.accepted,
          orderStateDate: _dateFormatter(orderData.orderAcceptedAt),
        ),
      );
      return CurrentOrderState.inProgress;
    } else if (CurrentOrderState.arrivedAtPickupPoint.name == orderData.state) {
      emit(
        state.copyWith(
          orderState: AppText.picked,
          orderStateDate: _dateFormatter(orderData.preparingYourOrderAt),
        ),
      );
      return CurrentOrderState.arrivedAtPickupPoint;
    } else if (CurrentOrderState.startDeliver.name == orderData.state) {
      emit(
        state.copyWith(
          orderState: AppText.outForDelivery,
          orderStateDate: _dateFormatter(orderData.outForDeliveryAt),
        ),
      );
      return CurrentOrderState.startDeliver;
    } else if (CurrentOrderState.arrivedToTheUser.name == orderData.state) {
      emit(
        state.copyWith(
          orderState: AppText.arrived,
          orderStateDate: _dateFormatter(orderData.arrivedAt),
        ),
      );
      return CurrentOrderState.arrivedToTheUser;
    } else if (CurrentOrderState.completed.name == orderData.state) {
      emit(
        state.copyWith(
          orderState: AppText.delivered,
          orderStateDate: _dateFormatter(orderData.deliveredAt),
        ),
      );
      return CurrentOrderState.completed;
    } else {
      emit(
        state.copyWith(
          orderState: AppText.delivered,
          orderStateDate: _dateFormatter(orderData.deliveredAt),
        ),
      );
      return CurrentOrderState.deliveredToTheUser;
    }
  }

  String? _dateFormatter(String? date) {
    if (date?.trim().isNotEmpty ?? false) {
      final dateTime = DateTime.parse(date!);
      final formattedDate = DateFormat(
        'E, dd MMM yyyy, hh:mm a',
        isArLanguage ? "ar" : "en",
      ).format(dateTime);
      return formattedDate;
    }
    return date;
  }

  @override
  Future<void> close() {
    _driverOrderSubscription?.cancel();
    return super.close();
  }
}
