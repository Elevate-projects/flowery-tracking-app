import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_intent.dart';
import 'package:flowery_tracking_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/logout/logout_use_case.dart';
import 'package:flowery_tracking_app/domain/use_cases/profile/get_profile_data_use_case.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

enum Languages { arabic, english }

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileDataUseCase _getProfileDataUseCase;
  final LogoutUseCase _logoutUseCase;
  final SecureStorage _secureStorage;

  ProfileCubit(
    this._getProfileDataUseCase,
    this._logoutUseCase,
    this._secureStorage,
  ) : super(const ProfileState());

  Future<void> doIntent(ProfileIntent intent) async {
    switch (intent) {
      case ProfileInitializationIntent():
        await _onInit(globalCubit: intent.globalCubit);
        break;
      case ToggleLanguageIntent():
        await _toggleLanguage(
          globalCubit: intent.globalCubit,
          newSelectedLanguage: intent.newSelectedLanguage,
        );
        break;
      case GetUserProfileDataIntent():
        await _getUserProfileData(isEdited: true);
        break;
      case LogoutIntent():
        await _logout();
        break;
    }
  }

  Future<void> _onInit({required GlobalCubit globalCubit}) async {
    emit(
      state.copyWith(
        selectedLanguage: globalCubit.isArLanguage
            ? Languages.arabic
            : Languages.english,
      ),
    );
    await _getUserProfileData();
  }

  Future<void> _getUserProfileData({bool? isEdited}) async {
    if (FloweryDriverMethodHelper.driverData == null || isEdited == true) {
      emit(state.copyWith(profileStatus: const StateStatus.loading()));
      final result = await _getProfileDataUseCase.call();
      if (isClosed) return;
      switch (result) {
        case Success<DriverDataEntity?>():
          FloweryDriverMethodHelper.driverData = result.data;
          emit(state.copyWith(profileStatus: StateStatus.success(result.data)));
        case Failure<DriverDataEntity?>():
          emit(
            state.copyWith(
              profileStatus: StateStatus.failure(result.responseException),
            ),
          );
          emit(state.copyWith(profileStatus: const StateStatus.initial()));
      }
    }
  }

  Future<void> _toggleLanguage({
    required GlobalCubit globalCubit,
    required Languages newSelectedLanguage,
  }) async {
    if (newSelectedLanguage != state.selectedLanguage) {
      await globalCubit.doIntent(
        intent: ChangeLanguageIntent(index: state.selectedLanguage.index),
      );
      emit(state.copyWith(selectedLanguage: newSelectedLanguage));
    }
  }

  Future<void> _logout() async {
    emit(state.copyWith(logoutStatus: const StateStatus.loading()));
    final result = await _logoutUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<void>():
        await _removeUserData();
        emit(state.copyWith(logoutStatus: const StateStatus.success(null)));
      case Failure<void>():
        emit(
          state.copyWith(
            logoutStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  Future<void> _removeUserData() async {
    await _secureStorage.deleteData(key: ConstKeys.tokenKey);
    FloweryDriverMethodHelper.currentUserToken = null;
    FloweryDriverMethodHelper.driverData = null;
  }
}
