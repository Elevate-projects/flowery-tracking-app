import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flutter/material.dart';

class ProfileResetPasswordState extends Equatable {
  final StateStatus<void> profileResetPasswordState;
  final AutovalidateMode autoValidateMode;

  const ProfileResetPasswordState({
    this.profileResetPasswordState = const StateStatus.initial(),
    this.autoValidateMode = AutovalidateMode.disabled,
  });

  ProfileResetPasswordState copyWith({
    StateStatus<void>? profileResetPasswordState,
    AutovalidateMode? autoValidateMode,
  }) {
    return ProfileResetPasswordState(
      profileResetPasswordState:
          profileResetPasswordState ?? this.profileResetPasswordState,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    );
  }

  @override
  List<Object?> get props => [profileResetPasswordState, autoValidateMode];
}
