import 'package:flowery_tracking_app/core/cache/shared_preferences_helper.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_intent.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_state.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GlobalCubit extends Cubit<GlobalState> {
  final SharedPreferencesHelper _sharedPreferencesHelper;
  GlobalCubit(this._sharedPreferencesHelper) : super(GlobalInitial());
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
    redirectedScreen = RouteNames.login;
    _getSelectedLanguage();
  }

  void _getSelectedLanguage() {
    isArLanguage = _sharedPreferencesHelper.getBool(
      key: ConstKeys.isArLanguage,
    );
    languageSelectedIndex = isArLanguage ? 1 : 0;
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
