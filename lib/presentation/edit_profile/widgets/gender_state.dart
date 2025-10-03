import 'package:flowery_tracking_app/presentation/edit_profile/widgets/enum.dart';

class GenderState {
  final Gender? selectedGender;

  GenderState({this.selectedGender});

  GenderState copyWith({Gender? selectedGender}) {
    return GenderState(
      selectedGender: selectedGender ?? this.selectedGender,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GenderState &&
        other.selectedGender == selectedGender;
  }

  @override
  int get hashCode => selectedGender.hashCode;

  @override
  String toString() => 'GenderState(selectedGender: $selectedGender)';
}
