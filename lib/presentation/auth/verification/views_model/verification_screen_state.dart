import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';

class VerificationScreenState extends Equatable {
  final StateStatus<void> verifyCodeStatus;
  final StateStatus<void> resendCodeStatus;
  final int secondsRemaining;
  final bool isError;

  const VerificationScreenState({
    this.secondsRemaining = 0,
    this.isError = false,
    this.verifyCodeStatus = const StateStatus.initial(),
    this.resendCodeStatus = const StateStatus.initial(),
  });

  VerificationScreenState copyWith({
    StateStatus<void>? verifyCodeStatus,
    int? secondsRemaining,
    bool? isError,
    StateStatus<void>? resendCodeStatus,
  }) {
    return VerificationScreenState(
      verifyCodeStatus: verifyCodeStatus ?? this.verifyCodeStatus,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      isError: isError ?? this.isError,
      resendCodeStatus: resendCodeStatus ?? this.resendCodeStatus,
    );
  }

  @override
  List<Object?> get props => [
    verifyCodeStatus,
    secondsRemaining,
    isError,
    resendCodeStatus,
  ];
}
