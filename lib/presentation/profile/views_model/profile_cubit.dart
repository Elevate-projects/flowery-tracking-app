import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_intent.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
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

  ProfileCubit(this._getProfileDataUseCase) : super(const ProfileState());

  Future<void> doIntent(ProfileIntent intent) async {
    switch (intent) {
      case ProfileInitializationIntent():
        await _onInit(globalCubit: intent.globalCubit);
      case ToggleLanguageIntent():
        await _toggleLanguage(
          globalCubit: intent.globalCubit,
          newSelectedLanguage: intent.newSelectedLanguage,
        );
      case GetUserProfileDataIntent():
        await _getUserProfileData(isEdited: true);
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
    if (FloweryDriverMethodHelper.currentUserToken != null) {
      await _getUserProfileData();
    }
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
}
