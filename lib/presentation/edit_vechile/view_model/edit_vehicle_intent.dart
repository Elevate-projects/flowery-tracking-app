sealed class EditVehicleIntent {}

class SubmitEditVehicle extends EditVehicleIntent {}

class SelectVehicleType extends EditVehicleIntent {
  final String vehicleType;
  SelectVehicleType(this.vehicleType);
}
