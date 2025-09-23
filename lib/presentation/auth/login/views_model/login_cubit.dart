import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/cache/shared_preferences_helper.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/login/login_with_email_and_password_use_case.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flowery_tracking_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginWithEmailAndPasswordUseCase _loginWithEmailAndPasswordUseCase;
  final SecureStorage _secureStorage;
  final SharedPreferencesHelper _sharedPreferencesHelper;
  @factoryMethod
  LoginCubit(
    this._loginWithEmailAndPasswordUseCase,
    this._secureStorage,
    this._sharedPreferencesHelper,
  ) : super(const LoginState());

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late GlobalKey<FormState> loginFormKey;

  Future<void> doIntent({required LoginIntent intent}) async {
    switch (intent) {
      case InitializeLoginFormIntent():
        _onInit();
        break;
      case LoginWithEmailAndPasswordIntent():
        await _login();
        break;
      case ToggleObscurePasswordIntent():
        _toggleObscure();
        break;
      case ToggleRememberMeIntent():
        await _toggleRememberMe();
        break;
      case CheckFieldsValidationIntent():
        _checkFieldsValidation();
        break;
      case EnableValidationIntent():
        _enableFieldsValidation();
        break;
    }
  }

  void _onInit() async {
    loginFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _getRememberMeValue();
    if (state.rememberMe) await _getRememberedUserData();
  }

  void _toggleObscure() {
    emit(
      state.copyWith(
        isObscure: !state.isObscure,
        loginStatus: const StateStatus.initial(),
      ),
    );
  }

  void _getRememberMeValue() {
    final bool isRemembered = _sharedPreferencesHelper.getBool(
      key: ConstKeys.rememberMe,
    );
    emit(state.copyWith(rememberMe: isRemembered));
  }

  Future<void> _toggleRememberMe() async {
    await _sharedPreferencesHelper.saveBool(
      key: ConstKeys.rememberMe,
      value: !state.rememberMe,
    );
    await _forgetUserData();
    emit(
      state.copyWith(
        rememberMe: !state.rememberMe,
        loginStatus: const StateStatus.initial(),
      ),
    );
  }

  Future<void> _rememberUserData() async {
    await _secureStorage.saveData(
      key: ConstKeys.email,
      value: emailController.text,
    );
    await _secureStorage.saveData(
      key: ConstKeys.password,
      value: passwordController.text,
    );
  }

  Future<void> _forgetUserData() async {
    await _secureStorage.deleteData(key: ConstKeys.email);
    await _secureStorage.deleteData(key: ConstKeys.password);
  }

  Future<void> _getRememberedUserData() async {
    emailController.text =
        await _secureStorage.getData(key: ConstKeys.email) ?? "";
    passwordController.text =
        await _secureStorage.getData(key: ConstKeys.password) ?? "";
  }

  void _checkFieldsValidation() {
    if (state.isContinueClickedWhenDisabled) {
      if (loginFormKey.currentState!.validate()) {
        emit(state.copyWith(isValidToLogin: true));
      } else {
        emit(state.copyWith(isValidToLogin: false));
      }
    } else {
      if (Validations.emailValidation(email: emailController.text.trim()) ==
              null &&
          Validations.passwordValidation(
                password: passwordController.text.trim(),
              ) ==
              null) {
        emit(state.copyWith(isValidToLogin: true));
      } else {
        emit(state.copyWith(isValidToLogin: false));
      }
    }
  }

  Future<void> _login() async {
    if (loginFormKey.currentState!.validate()) {
      emit(state.copyWith(loginStatus: const StateStatus.loading()));
      final userData = await _loginWithEmailAndPasswordUseCase.invoke(
        request: LoginRequestEntity(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      switch (userData) {
        case Success<void>():
          {
            if (state.rememberMe) await _rememberUserData();
            emit(state.copyWith(loginStatus: const StateStatus.success(null)));
            break;
          }
        case Failure<void>():
          emit(
            state.copyWith(
              loginStatus: StateStatus.failure(userData.responseException),
            ),
          );
          break;
      }
    }
  }

  void _enableFieldsValidation() {
    emit(state.copyWith(isContinueClickedWhenDisabled: true));
    _checkFieldsValidation();
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
