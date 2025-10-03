import 'package:flowery_tracking_app/presentation/edit_profile/widgets/enum.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/gender_intent.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/gender_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderCubit extends Cubit<GenderState> {
  GenderCubit() : super(GenderState());

  void doIntent({required GenderIntent intent}) {
    if (intent is ChangeGenderIntent) {
      _changeGender(intent.selectedGender);
    }
  }
  void _changeGender(Gender gender) {
    emit(state.copyWith(selectedGender: gender));
  }
}
