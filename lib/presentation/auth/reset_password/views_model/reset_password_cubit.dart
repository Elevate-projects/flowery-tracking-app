import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/reset_password/reset_password_response.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/reset_password/reset_password_usecase.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  GetResetPasswordUseCase getResetPasswordUseCase;

  @factoryMethod
  ResetPasswordCubit(this.getResetPasswordUseCase)
    : super(const ResetPasswordState());
  late GlobalKey<FormState> formKey;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late AutovalidateMode autoValidateMode;

  void doIntent(ResetPasswordIntent intent) {
    switch (intent) {
      case OnResetPasswordIntent():
        return _resetPassword(intent.request);
      case InitializeResetPasswordFormIntent():
        return _onInit();
    }
  }

  void _onInit() {
    formKey = GlobalKey<FormState>();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    autoValidateMode = AutovalidateMode.disabled;
  }

  void _enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  void _resetPassword(ResetPasswordRequestEntity request) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(resetPasswordState: const StateStatus.loading()));
      final res = await getResetPasswordUseCase.execute(request);
      switch (res) {
        case Success<ResetPasswordResponse>():
          emit(
            state.copyWith(resetPasswordState: const StateStatus.success(null)),
          );
        case Failure<ResetPasswordResponse>():
          emit(
            state.copyWith(
              resetPasswordState: StateStatus.failure(res.responseException),
            ),
          );
      }
    } else {
      _enableAutoValidateMode();
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
