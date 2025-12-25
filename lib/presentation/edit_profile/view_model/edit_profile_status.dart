import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
final class EditProfileState extends Equatable{
  final bool isObscure;
  final bool isFormValid;
  final StateStatus<void> editProfileStatus;
  final StateStatus<File> uploadPhotoState;
  final DriverDataEntity? driverData;
  const EditProfileState({
    this.isFormValid = false,
    this.driverData,
    this.isObscure = true,
    this.editProfileStatus = const StateStatus.initial(),
    this.uploadPhotoState = const StateStatus.initial()
});
  EditProfileState copyWith({
    bool? isFormValid,
    DriverDataEntity? driverData,
    bool? isObscure,
    StateStatus<void>? editProfileStatus,
    StateStatus<File>? uploadPhotoState,
  })
  {
    return  EditProfileState(
      isFormValid: isFormValid ?? this.isFormValid,
      driverData: driverData ?? this.driverData,
      isObscure: isObscure ?? this.isObscure,
      editProfileStatus: editProfileStatus ?? this.editProfileStatus,
      uploadPhotoState: uploadPhotoState ?? this.uploadPhotoState,
      
    );
  }
  @override
  List<Object?> get props => [
    isFormValid,
    driverData,
    isObscure,
    editProfileStatus,
    uploadPhotoState,
  ];
}