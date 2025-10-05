import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/requests/edit_vehicle/edit_vehicle_request.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
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

  late final TextEditingController vehicleTypeController;
  late final TextEditingController vehicleNumberController;
  late final TextEditingController vehicleLicenseController;
  late final GlobalKey<FormState> formKey;

  @factoryMethod
  EditVehicleCubit(this._useCase) : super(const EditVehicleStatus()) {
    formKey = GlobalKey<FormState>();
    final user = FloweryDriverMethodHelper.driverData;
    vehicleTypeController =
        TextEditingController(text: user?.vehicleType ?? "");
    vehicleNumberController =
        TextEditingController(text: user?.vehicleNumber ?? "");
    vehicleLicenseController =
        TextEditingController(text: user?.vehicleLicense ?? "");
    vehicleTypeController.addListener(validateForm);
    vehicleNumberController.addListener(validateForm);
    vehicleLicenseController.addListener(validateForm);
  }

  Future<void> doIntent({required EditVehicleIntent intent}) async {
    switch (intent) {
      default:
        break;
    }
  }

  Future<void> editVehicle() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      emit(state.copyWith(editVehicleStatus: const StateStatus.loading()));

      final result = await _useCase.editVehicle(
        EditVehicleRequest(
          vehicleType: vehicleTypeController.text,
          vehicleNumber: vehicleNumberController.text,
          vehicleLicense: vehicleLicenseController.text,
        ),
      );

      switch (result) {
        case Success<DriverDataEntity>(:final data):
          emit(
            state.copyWith(
              editVehicleStatus: const StateStatus.success(null),
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
    final isValid = vehicleTypeController.text.isNotEmpty &&
        vehicleNumberController.text.isNotEmpty &&
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
