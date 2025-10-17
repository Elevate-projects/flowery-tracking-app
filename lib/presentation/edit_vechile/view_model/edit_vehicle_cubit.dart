import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/entities/edit_vehicle/edit_vehicle_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/edit_vehicle/edit_vehicle_use_case.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view_model/edit_vehicle_intent.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view_model/edit_vehicle_status.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class EditVehicleCubit extends Cubit<EditVehicleStatus> {
  final EditVehicleUseCase _useCase;

  // Private controllers
  late final TextEditingController _vehicleTypeController;
  late final TextEditingController _vehicleNumberController;
  late final TextEditingController _vehicleLicenseController;
  late final GlobalKey<FormState> _formKey;

  @factoryMethod
  EditVehicleCubit(this._useCase) : super(const EditVehicleStatus()) {
    _formKey = GlobalKey<FormState>();
    final user = FloweryDriverMethodHelper.driverData;
    _vehicleTypeController =
        TextEditingController(text: user?.vehicleType ?? "");
    _vehicleNumberController =
        TextEditingController(text: user?.vehicleNumber ?? "");
    _vehicleLicenseController =
        TextEditingController(text: user?.vehicleLicense ?? "");

    _vehicleTypeController.addListener(_validateForm);
    _vehicleNumberController.addListener(_validateForm);
    _vehicleLicenseController.addListener(_validateForm);

    _validateForm();
  }

  /// Public API for UI
  Future<void> onIntent(EditVehicleIntent intent) async {
    switch (intent) {
      case SubmitEditVehicle():
        await _submitEditVehicle();
        break;
    }
  }

  // Private function to submit the edit vehicle request
  Future<void> _submitEditVehicle() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    emit(state.copyWith(editVehicleStatus: const StateStatus.loading()));

    final result = await _useCase.editVehicle(
      EditVehicleEntity(
        _vehicleTypeController.text,
        _vehicleNumberController.text,
        _vehicleLicenseController.text,
      ),
    );

    switch (result) {
      case Success<DriverDataEntity>(:final data):
        FloweryDriverMethodHelper.driverData = data;
        emit(state.copyWith(
          editVehicleStatus: const StateStatus.success(null),
          driverData: data,
        ));
        break;
      case Failure<DriverDataEntity>():
        emit(state.copyWith(
          editVehicleStatus: StateStatus.failure(result.responseException),
        ));
        break;
    }
  }

  // Private validation function
  void _validateForm() {
    final isValid = _vehicleTypeController.text.isNotEmpty &&
        _vehicleNumberController.text.isNotEmpty &&
        _vehicleLicenseController.text.isNotEmpty;
     if (state.isFormValid != isValid) {
       emit(state.copyWith(isFormValid: isValid));
      }
  }

  // Public getters for UI binding
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get vehicleTypeController => _vehicleTypeController;
  TextEditingController get vehicleNumberController => _vehicleNumberController;
  TextEditingController get vehicleLicenseController =>
      _vehicleLicenseController;

  @override
  Future<void> close() {
    _vehicleTypeController.dispose();
    _vehicleNumberController.dispose();
    _vehicleLicenseController.dispose();
    return super.close();
  }
}

