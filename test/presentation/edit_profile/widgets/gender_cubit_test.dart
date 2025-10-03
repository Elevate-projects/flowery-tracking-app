import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/enum.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/gender_intent.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/gender_state.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/gender_cubit.dart';

void main() {
  group('GenderCubit Test', () {
    late GenderCubit genderCubit;

    setUp(() {
      genderCubit = GenderCubit();
    });

    tearDown(() {
      genderCubit.close();
    });

    test('initial state should be GenderState with null gender', () {
      expect(genderCubit.state, GenderState());
    });

    blocTest<GenderCubit, GenderState>(
      'emits [GenderState(selectedGender: Gender.male)] when ChangeGenderIntent(Gender.male) is added',
      build: () => GenderCubit(),
      act: (cubit) => cubit.doIntent(intent: ChangeGenderIntent(selectedGender: Gender.male)),
      expect: () => [
        GenderState(selectedGender: Gender.male),
      ],
    );

    blocTest<GenderCubit, GenderState>(
      'emits [GenderState(selectedGender: Gender.female)] when ChangeGenderIntent(Gender.female) is added',
      build: () => GenderCubit(),
      act: (cubit) => cubit.doIntent(intent: ChangeGenderIntent(selectedGender: Gender.female)),
      expect: () => [
        GenderState(selectedGender: Gender.female),
      ],
    );
  });
}
