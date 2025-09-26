import 'dart:io';

import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/apply_request/apply_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/apply/apply_use_case.dart';
import 'package:flowery_tracking_app/domain/use_cases/country/get_all_countries_use_case.dart';
import 'package:flowery_tracking_app/domain/use_cases/vehicle/get_all_vehicles_use_case.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views_body/apply_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views_body/apply_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

enum Gender { male, female }

@injectable
class ApplyCubit extends Cubit<ApplyState> {
  final GetAllCountriesUseCase _getAllCountriesUseCase;
  final GetAllVehiclesUseCase _getAllVehiclesUseCase;
  final ApplyUseCase _applyUseCase;
  ApplyCubit(
    this._getAllCountriesUseCase,
    this._getAllVehiclesUseCase,
    this._applyUseCase,
  ) : super(const ApplyState());

  late final TextEditingController firstLegalNameController;
  late final TextEditingController secondLegalNameController;
  late final TextEditingController vehicleTypeLegalNameController;
  late final TextEditingController vehicleNumberController;
  late final TextEditingController vehicleLicenseController;
  late final TextEditingController emailController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController idNumberController;
  late final TextEditingController idImageController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final ImagePicker _imagePicker;
  late GlobalKey<FormState> applyFormKey;

  Future<void> doIntent({required ApplyIntent intent}) async {
    switch (intent) {
      case ApplyInitializationIntent():
        _onInit();
        break;
      case ChangeGenderIntent():
        _changeGender(gender: intent.selectedGender);
        break;
      case ChangeCountryIntent():
        _changeSelectedCountry(country: intent.selectedCountry);
        break;
      case ApplyFormIntent():
        await _apply();
        break;
      case PickVehicleLicenseImageIntent():
        await _pickVehicleLicenseImage();
        break;
      case PickIdImageIntent():
        await _pickIdImage();
        break;
      case ChangeVehicleIntent():
        _changeSelectedVehicle(vehicle: intent.selectedVehicle);
        break;
      case ToggleObscurePasswordIntent():
        _togglePasswordObscure();
        break;
      case ToggleConfirmObscurePasswordIntent():
        _toggleConfirmPasswordObscure();
        break;
    }
  }

  void _onInit() async {
    applyFormKey = GlobalKey<FormState>();
    firstLegalNameController = TextEditingController();
    secondLegalNameController = TextEditingController();
    vehicleTypeLegalNameController = TextEditingController();
    vehicleNumberController = TextEditingController();
    vehicleLicenseController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    idNumberController = TextEditingController();
    idImageController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    _imagePicker = ImagePicker();
    _getAllCountries();
    _getAllVehicles();
  }

  void _enableAutoValidateMode() {
    emit(state.copyWith(autoValidateMode: AutovalidateMode.always));
  }

  void _togglePasswordObscure() {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  void _toggleConfirmPasswordObscure() {
    emit(state.copyWith(isObscureConfirm: !state.isObscureConfirm));
  }

  Future<void> _apply() async {
    if (applyFormKey.currentState!.validate()) {
      emit(state.copyWith(applyStatus: const StateStatus.loading()));
      final result = await _applyUseCase.invoke(
        request: ApplyRequestEntity(
          country: state.selectedCountry?.countryName ?? "",
          firstName: firstLegalNameController.text.trim(),
          lastName: secondLegalNameController.text.trim(),
          vehicleType: state.selectedVehicle?.id ?? "",
          vehicleNumber: vehicleNumberController.text.trim(),
          nid: idNumberController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          rePassword: confirmPasswordController.text.trim(),
          gender: state.selectedGender?.name ?? "",
          phone: phoneNumberController.text.trim(),
          nidImg: File(state.idImage!.path),
          vehicleLicense: File(state.vehicleLicenseImage!.path),
        ),
      );
      switch (result) {
        case Success<void>():
          emit(state.copyWith(applyStatus: const StateStatus.success(null)));
          break;
        case Failure<void>():
          emit(
            state.copyWith(
              applyStatus: StateStatus.failure(result.responseException),
            ),
          );
          break;
      }
    } else {
      _enableAutoValidateMode();
    }
  }

  Future<void> _pickVehicleLicenseImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      vehicleLicenseController.text = pickedFile.name;
      emit(state.copyWith(vehicleLicenseImage: pickedFile));
    }
  }

  Future<void> _pickIdImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      idImageController.text = pickedFile.name;
      emit(state.copyWith(idImage: pickedFile));
    }
  }

  Future<void> _getAllCountries() async {
    emit(state.copyWith(countryStatus: const StateStatus.loading()));
    final result = await _getAllCountriesUseCase.invoke();
    switch (result) {
      case Success<List<CountryEntity>>():
        emit(state.copyWith(countryStatus: StateStatus.success(result.data)));
        break;
      case Failure<List<CountryEntity>>():
        emit(
          state.copyWith(
            countryStatus: StateStatus.failure(result.responseException),
          ),
        );
        break;
    }
  }

  Future<void> _getAllVehicles() async {
    emit(state.copyWith(vehicleStatus: const StateStatus.loading()));
    final result = await _getAllVehiclesUseCase.invoke();
    switch (result) {
      case Success<List<VehicleEntity>>():
        emit(state.copyWith(vehicleStatus: StateStatus.success(result.data)));
        break;
      case Failure<List<VehicleEntity>>():
        emit(
          state.copyWith(
            vehicleStatus: StateStatus.failure(result.responseException),
          ),
        );
        break;
    }
  }

  void _changeGender({required Gender? gender}) {
    emit(state.copyWith(selectedGender: gender));
  }

  void _changeSelectedCountry({required CountryEntity? country}) {
    emit(state.copyWith(selectedCountry: country));
  }

  void _changeSelectedVehicle({required VehicleEntity? vehicle}) {
    emit(state.copyWith(selectedVehicle: vehicle));
  }

  @override
  Future<void> close() {
    firstLegalNameController.dispose();
    secondLegalNameController.dispose();
    vehicleTypeLegalNameController.dispose();
    vehicleNumberController.dispose();
    vehicleLicenseController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    idNumberController.dispose();
    idImageController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
