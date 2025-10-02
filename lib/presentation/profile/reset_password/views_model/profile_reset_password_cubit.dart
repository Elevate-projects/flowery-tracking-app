import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/profile_reset_password/profile_reset_password_response.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/requests/profile_reset_password/profile_reset_password_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/profile_reset_password/profile_reset_password_usecase.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_intent.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileResetPasswordCubit extends Cubit<ProfileResetPasswordState> {
  final GetProfileResetPasswordUseCase _useCase;

  @factoryMethod
  ProfileResetPasswordCubit(this._useCase)
    : super(const ProfileResetPasswordState());
  late GlobalKey<FormState> formKey;
  late final TextEditingController currentPasswordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;

  void doIntent(ProfileResetPasswordIntent intent) {
    switch (intent) {
      case InitializeProfileResetPasswordFormIntent():
        return _onInit();
      case OnProfileResetPasswordIntent():
        return _profileResetPassword(intent.request);
    }
  }

  void _onInit() {
    formKey = GlobalKey<FormState>();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emit(state.copyWith(autoValidateMode: AutovalidateMode.disabled));
  }

  void _enableAutoValidateMode() {
    emit(state.copyWith(autoValidateMode: AutovalidateMode.always));
  }

  void _profileResetPassword(ProfileResetPasswordRequestEntity request) async {
    if (formKey.currentState!.validate()) {
      emit(
        state.copyWith(profileResetPasswordState: const StateStatus.loading()),
      );
      final res = await _useCase.execute(request);
      switch (res) {
        case Success<ProfileResetPasswordResponse>():
          emit(
            state.copyWith(
              profileResetPasswordState: const StateStatus.success(null),
            ),
          );
        case Failure<ProfileResetPasswordResponse>():
          emit(
            state.copyWith(
              profileResetPasswordState: StateStatus.failure(
                res.responseException,
              ),
            ),
          );
      }
    } else {
      _enableAutoValidateMode();
    }
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
