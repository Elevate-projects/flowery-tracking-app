import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flutter/cupertino.dart';

class ForgetPasswordAndResendCodeState extends Equatable {
  final StateStatus<void> forgetPasswordAndResendCodeStatus;
  final AutovalidateMode autoValidateMode;

  const ForgetPasswordAndResendCodeState({
    this.autoValidateMode = AutovalidateMode.disabled,
    this.forgetPasswordAndResendCodeStatus = const StateStatus.initial(),
  });

  ForgetPasswordAndResendCodeState copyWith({
    StateStatus<void>? status,
    AutovalidateMode? autoValidateMode,
  }) {
    return ForgetPasswordAndResendCodeState(
      forgetPasswordAndResendCodeStatus:
          status ?? forgetPasswordAndResendCodeStatus,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    );
  }

  @override
  List<Object?> get props => [
    forgetPasswordAndResendCodeStatus,
    autoValidateMode,
  ];
}

final class EnableAutoValidateModeState
    extends ForgetPasswordAndResendCodeState {
  @override
  List<Object?> get props => [];
}
