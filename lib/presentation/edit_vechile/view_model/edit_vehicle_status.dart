import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';

class EditVehicleStatus extends Equatable {
  final List<String> vehicleTypes;
  final bool isFormValid;
  final DriverDataEntity? driverData;
  final StateStatus<void> editVehicleStatus;
  final String? selectedVehicleType;

  const EditVehicleStatus({
    this.vehicleTypes = const [
      "Motor Cycle",
      "Compact",
      "Sedan",
      "Semi",
      "Sports",
      "SUV",
      "Truck",
    ],
    this.editVehicleStatus = const StateStatus.initial(),
    this.isFormValid = false,
    this.driverData,
    this.selectedVehicleType,
  });

  EditVehicleStatus copyWith({
    List<String>? vehicleTypes,
    StateStatus<void>? editVehicleStatus,
    bool? isFormValid,
    DriverDataEntity? driverData,
    String? selectedVehicleType,
  }) {
    return EditVehicleStatus(
      vehicleTypes: vehicleTypes ?? this.vehicleTypes,
      editVehicleStatus: editVehicleStatus ?? this.editVehicleStatus,
      isFormValid: isFormValid ?? this.isFormValid,
      driverData: driverData ?? this.driverData,
      selectedVehicleType: selectedVehicleType ?? this.selectedVehicleType,
    );
  }

  @override
  List<Object?> get props => [
        vehicleTypes,
        editVehicleStatus,
        isFormValid,
        driverData,
        selectedVehicleType,
      ];
}
