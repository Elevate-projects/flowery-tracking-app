import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flutter/material.dart';

class ResetPasswordState extends Equatable {
  final StateStatus<void> resetPasswordState;
  final AutovalidateMode autoValidateMode;

  const ResetPasswordState({
    this.resetPasswordState = const StateStatus.initial(),
    this.autoValidateMode = AutovalidateMode.disabled,
  });

  ResetPasswordState copyWith({
    StateStatus<void>? resetPasswordState,
    AutovalidateMode? autoValidateMode,
  }) {
    return ResetPasswordState(
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    );
  }

  @override
  List<Object?> get props => [resetPasswordState, autoValidateMode];
}

final class EnableAutoValidateModeState extends ResetPasswordState {
  @override
  List<Object?> get props => [];
}
