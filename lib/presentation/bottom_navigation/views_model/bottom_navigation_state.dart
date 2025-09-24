import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';

class BottomNavigationState extends Equatable {
  final int currentIndex;

  final StateStatus<void> bottomState;

  const BottomNavigationState({
    this.bottomState = const StateStatus.initial(),
    this.currentIndex = 0,
  });

  BottomNavigationState copyWith({
    int? currentIndex,

    StateStatus<void>? bottomState,
  }) {
    return BottomNavigationState(
      bottomState: bottomState ?? this.bottomState,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [currentIndex, bottomState];

}
