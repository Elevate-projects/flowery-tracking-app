import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';

class EditVehicleStatus extends Equatable{
  final bool isFormValid;
  final DriverDataEntity? driverData;
  final StateStatus<void> editVehicleStatus;
const EditVehicleStatus({
     this.editVehicleStatus = const StateStatus.initial(),
     this.isFormValid =  false,
     this.driverData,
});
EditVehicleStatus copyWith({
    StateStatus<void>? editVehicleStatus,
    bool? isFormValid,
  DriverDataEntity? driverData,
})
{
    return EditVehicleStatus(
      editVehicleStatus : editVehicleStatus ?? this.editVehicleStatus,
      isFormValid: isFormValid ?? this.isFormValid,
      driverData: driverData ?? this.driverData,
    );
}
@override
List<Object?> get props => [
  editVehicleStatus,
  isFormValid,driverData];
}