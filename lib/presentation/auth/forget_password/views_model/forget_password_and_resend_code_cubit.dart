import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/forget_password_and_resend_code/forget_password_and_resend_code_response.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/forget_password_and_resend_code/forget_password_and_resend_code_usecase.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordAndResendCodeCubit
    extends Cubit<ForgetPasswordAndResendCodeState> {
  final GetForgetPasswordResendCodeUseCase _forgetPasswordResendCodeUseCase;

  ForgetPasswordAndResendCodeCubit(this._forgetPasswordResendCodeUseCase)
    : super(const ForgetPasswordAndResendCodeState());

  late GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late AutovalidateMode autoValidateMode;

  void doIntent(ForgetPasswordAndResendCodeIntent intent) {
    switch (intent) {
      case OnConfirmEmailClickIntent():
        return _forgetPasswordAndResendCode(intent.request);
      case InitializeForgetPasswordFormIntent():
        return _onInit();
    }
  }

  void _onInit() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    autoValidateMode = AutovalidateMode.disabled;
  }

  void _enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  void _forgetPasswordAndResendCode(
    ForgetPasswordAndResendCodeRequestEntity request,
  ) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(status: const StateStatus.loading()));
      final res = await _forgetPasswordResendCodeUseCase.execute(request);
      switch (res) {
        case Success<ForgetPasswordAndResendCodeResponse>():
          emit(state.copyWith(status: const StateStatus.success(null)));
        case Failure<ForgetPasswordAndResendCodeResponse>():
          emit(
            state.copyWith(status: StateStatus.failure(res.responseException)),
          );
      }
    } else {
      _enableAutoValidateMode();
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
