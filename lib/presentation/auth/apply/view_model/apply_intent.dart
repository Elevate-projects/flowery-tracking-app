import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';
import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_cubit.dart';

sealed class ApplyIntent {
  const ApplyIntent();
}

final class ApplyInitializationIntent extends ApplyIntent {
  const ApplyInitializationIntent();
}

final class ChangeGenderIntent extends ApplyIntent {
  final Gender? selectedGender;
  const ChangeGenderIntent({required this.selectedGender});
}

final class ChangeCountryIntent extends ApplyIntent {
  final CountryEntity? selectedCountry;
  const ChangeCountryIntent({required this.selectedCountry});
}

final class ApplyFormIntent extends ApplyIntent {
  const ApplyFormIntent();
}

final class PickVehicleLicenseImageIntent extends ApplyIntent {
  const PickVehicleLicenseImageIntent();
}

final class PickIdImageIntent extends ApplyIntent {
  const PickIdImageIntent();
}

final class ChangeVehicleIntent extends ApplyIntent {
  final VehicleEntity? selectedVehicle;
  const ChangeVehicleIntent({required this.selectedVehicle});
}

final class ToggleObscurePasswordIntent extends ApplyIntent {
  const ToggleObscurePasswordIntent();
}

final class ToggleConfirmObscurePasswordIntent extends ApplyIntent {
  const ToggleConfirmObscurePasswordIntent();
}

// final class ExtractLicensePlateIntent extends ApplyIntent {
//   const ExtractLicensePlateIntent();
// }
