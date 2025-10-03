import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';
import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_cubit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ApplyState extends Equatable {
  final StateStatus<void> applyStatus;
  final StateStatus<List<CountryEntity>> countryStatus;
  final StateStatus<List<VehicleEntity>> vehicleStatus;
  final bool isObscure;
  final bool isObscureConfirm;
  final Gender? selectedGender;
  final AutovalidateMode autoValidateMode;
  final CountryEntity? selectedCountry;
  final VehicleEntity? selectedVehicle;
  final XFile? vehicleLicenseImage;
  final XFile? idImage;

  const ApplyState({
    this.countryStatus = const StateStatus.initial(),
    this.applyStatus = const StateStatus.initial(),
    this.vehicleStatus = const StateStatus.initial(),
    this.isObscure = true,
    this.isObscureConfirm = true,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.selectedGender,
    this.selectedCountry,
    this.vehicleLicenseImage,
    this.idImage,
    this.selectedVehicle,
  });

  ApplyState copyWith({
    StateStatus<void>? applyStatus,
    StateStatus<List<CountryEntity>>? countryStatus,
    StateStatus<List<VehicleEntity>>? vehicleStatus,
    bool? isObscure,
    bool? isObscureConfirm,
    AutovalidateMode? autoValidateMode,
    Gender? selectedGender,
    CountryEntity? selectedCountry,
    XFile? vehicleLicenseImage,
    XFile? idImage,
    VehicleEntity? selectedVehicle,
  }) {
    return ApplyState(
      applyStatus: applyStatus ?? this.applyStatus,
      isObscure: isObscure ?? this.isObscure,
      isObscureConfirm: isObscureConfirm ?? this.isObscureConfirm,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      selectedGender: selectedGender ?? this.selectedGender,
      countryStatus: countryStatus ?? this.countryStatus,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      vehicleLicenseImage: vehicleLicenseImage ?? this.vehicleLicenseImage,
      idImage: idImage ?? this.idImage,
      vehicleStatus: vehicleStatus ?? this.vehicleStatus,
      selectedVehicle: selectedVehicle ?? this.selectedVehicle,
    );
  }

  @override
  List<Object?> get props => [
    applyStatus,
    isObscure,
    isObscureConfirm,
    autoValidateMode,
    selectedGender,
    countryStatus,
    selectedCountry,
    vehicleLicenseImage,
    idImage,
    vehicleStatus,
    selectedVehicle,
  ];
}