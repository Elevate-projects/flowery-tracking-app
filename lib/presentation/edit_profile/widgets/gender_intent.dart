import 'package:flowery_tracking_app/presentation/edit_profile/widgets/enum.dart';

abstract class GenderIntent {}

class ChangeGenderIntent extends GenderIntent {
  final Gender selectedGender;

  ChangeGenderIntent({required this.selectedGender});
}
