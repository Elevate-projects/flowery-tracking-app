import 'dart:async';

import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/forget_password_and_resend_code/forget_password_and_resend_code_response.dart';
import 'package:flowery_tracking_app/api/responses/verification/verify_response.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/forget_password_and_resend_code/forget_password_and_resend_code_usecase.dart';
import 'package:flowery_tracking_app/domain/use_cases/verification/verification_usecase.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerificationScreenCubit extends Cubit<VerificationScreenState> {
  final GetVerificationUseCase _getVerificationUseCase;
  final GetForgetPasswordResendCodeUseCase _getResendCodeUseCase;

  Timer? _timer;

  VerificationScreenCubit(
    this._getVerificationUseCase,
    this._getResendCodeUseCase,
  ) : super(const VerificationScreenState());

  void doIntent(VerificationScreenIntent intent) {
    switch (intent) {
      case OnVerificationIntent():
        return _verify(intent.request);
      case OnStartTimer():
        return _startTimer();
      case OnResendCodeClickIntent():
        return _resendCode(intent.request);
    }
  }

  void _resendCode(ForgetPasswordAndResendCodeRequestEntity request) async {
    emit(state.copyWith(resendCodeStatus: const StateStatus.loading()));
    final res = await _getResendCodeUseCase.execute(request);
    switch (res) {
      case Success<ForgetPasswordAndResendCodeResponse>():
        _startTimer();
        emit(state.copyWith(resendCodeStatus: const StateStatus.success(null)));
      case Failure<ForgetPasswordAndResendCodeResponse>():
        emit(
          state.copyWith(
            resendCodeStatus: StateStatus.failure(res.responseException),
          ),
        );
    }
  }

  void _verify(VerifyRequestEntity request) async {
    emit(state.copyWith(verifyCodeStatus: const StateStatus.loading()));
    final res = await _getVerificationUseCase.execute(request);
    switch (res) {
      case Success<VerifyResponse>():
        emit(
          state.copyWith(
            verifyCodeStatus: const StateStatus.success(null),
            isError: false,
          ),
        );
      case Failure<VerifyResponse>():
        emit(
          state.copyWith(
            verifyCodeStatus: StateStatus.failure(res.responseException),
            isError: true,
          ),
        );
    }
  }

  void _startTimer() {
    _timer?.cancel();
    int seconds = 30;
    emit(state.copyWith(secondsRemaining: seconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        emit(state.copyWith(secondsRemaining: seconds));
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
