import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/requests/edit_vechicle/edit_vehicle_request.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/edit_vehicle/edit_vehicle_use_case.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view_model/edit_vehicle_intent.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view_model/edit_vehicle_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class EditVehicleCubit extends Cubit<EditVehicleStatus>{
  final EditVehicleUseCase _useCase;
  late final TextEditingController vehicleTypeController;
  late final TextEditingController vehicleNumberController;
  late final TextEditingController vehicleLicenseController;
  late final GlobalKey<FormState> formKey;
  EditVehicleCubit(this._useCase) : super(const EditVehicleStatus()){
    vehicleTypeController = TextEditingController();
    vehicleNumberController = TextEditingController();
    vehicleLicenseController = TextEditingController();
    formKey = GlobalKey<FormState>();
    vehicleTypeController.addListener(validateForm);
    vehicleNumberController.addListener(validateForm);
    vehicleLicenseController.addListener(validateForm);
  }
  Future<void> doIntent({required EditVehicleIntent intent}) async {
    switch(intent){
      case EditVehicleIntent():
        break;
    }
  }
  Future<void> editVehicle() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(editVehicleStatus: const StateStatus.loading()));
      final result = await _useCase.editVehicle(
        EditVehicleRequest(
          vehicleType: vehicleTypeController.text,
          vehicleNumber: vehicleNumberController.text,
          vehicleLicense: vehicleLicenseController.text,
        ),
      );
      switch(result){
        case Success<DriverDataEntity>(:final data):
          emit(
            state.copyWith(
              editVehicleStatus: const StateStatus.success(
                null,
              ),
              driverData: data,
            ),
          );
          break;
        case Failure<DriverDataEntity>():
          emit(
            state.copyWith(
              editVehicleStatus: StateStatus.failure(result.responseException),
            ),
          );
          break;
      }
    }
  }
  void validateForm() {
    final isValid = vehicleNumberController.text.isNotEmpty &&
        vehicleTypeController.text.isNotEmpty &&
        vehicleLicenseController.text.isNotEmpty;
    emit(state.copyWith(isFormValid: isValid));
  }
  @override
  Future<void> close() {
    vehicleTypeController.dispose();
    vehicleNumberController.dispose();
    vehicleLicenseController.dispose();
    return super.close();
  }
}