import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/cache/shared_preferences_helper.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_intent.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_state.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/fetch_all_driver_orders/fetch_all_driver_orders_use_case.dart';
import 'package:flowery_tracking_app/domain/use_cases/profile/get_profile_data_use_case.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:injectable/injectable.dart';

@injectable
class GlobalCubit extends Cubit<GlobalState> {
  final SecureStorage _secureStorage;
  final SharedPreferencesHelper _sharedPreferencesHelper;
  final FetchAllDriverOrdersUseCase _fetchAllDriverOrdersUseCase;
  final GetProfileDataUseCase _getProfileDataUseCase;

  GlobalCubit(
    this._secureStorage,
    this._sharedPreferencesHelper,
    this._fetchAllDriverOrdersUseCase,
    this._getProfileDataUseCase,
  ) : super(GlobalInitial());
  String? redirectedScreen;
  late bool isArLanguage;
  late int languageSelectedIndex;

  Future<void> doIntent({required GlobalIntent intent}) async {
    switch (intent) {
      case GlobalInitializationIntent():
        await _onInit();
      case ChangeLanguageIntent():
        await _changedLanguageIndex(index: intent.index);
    }
  }

  Future<void> _onInit() async {
    _getSelectedLanguage();
    await _setRedirectedScreen();
  }

  void _getSelectedLanguage() {
    isArLanguage = _sharedPreferencesHelper.getBool(
      key: ConstKeys.isArLanguage,
    );
    languageSelectedIndex = isArLanguage ? 1 : 0;
  }

  Future<void> _setRedirectedScreen() async {
    bool isFailure = false;
    final userToken = await _secureStorage.getData(key: ConstKeys.tokenKey);
    final isRemembered = _sharedPreferencesHelper.getBool(
      key: ConstKeys.rememberMe,
    );
    if (userToken != null) {
      FloweryDriverMethodHelper.currentUserToken = userToken;
      final driverDataResult = await _getProfileDataUseCase.call();
      switch (driverDataResult) {
        case Success<DriverDataEntity?>():
          FloweryDriverMethodHelper.driverData = driverDataResult.data;
          break;
        case Failure<DriverDataEntity?>():
          isFailure = true;
          break;
      }
      final result = await _fetchAllDriverOrdersUseCase.invoke();
      switch (result) {
        case Success<String?>():
          {
            if (result.data != null) {
              FloweryDriverMethodHelper.currentDriverOrderId = result.data;
            }
          }
          break;
        case Failure<String?>():
          isFailure = true;
          break;
      }
    }
    if (userToken != null && isRemembered) {
      if (FloweryDriverMethodHelper.currentDriverOrderId != null) {
        redirectedScreen = RouteNames.orderDetails;
      } else if (isFailure) {
        await _secureStorage.deleteData(key: ConstKeys.tokenKey);
        redirectedScreen = RouteNames.login;
      } else {
        redirectedScreen = RouteNames.bottomNavigation;
      }
    } else {
      redirectedScreen = RouteNames.onboarding;
    }
    FlutterNativeSplash.remove();
    emit(LoadedRedirectedScreen());
  }

  Future<void> _changedLanguageIndex({required int index}) async {
    if (languageSelectedIndex != index && index == 0) {
      languageSelectedIndex = index;
      await _sharedPreferencesHelper.saveBool(
        key: ConstKeys.isArLanguage,
        value: false,
      );
      isArLanguage = false;
      emit(ChangeLanguageIndexState());
    } else if (languageSelectedIndex != index && index == 1) {
      languageSelectedIndex = index;
      await _sharedPreferencesHelper.saveBool(
        key: ConstKeys.isArLanguage,
        value: true,
      );
      isArLanguage = true;
      emit(ChangeLanguageIndexState());
    }
  }
}
