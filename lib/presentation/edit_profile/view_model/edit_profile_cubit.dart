import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/entities/edit_profile/edit_profile_entity.dart';
import 'package:flowery_tracking_app/domain/upload_photo_response_entity/upload_photo_response_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';
import 'package:flowery_tracking_app/domain/use_cases/edit_profile/upload_photo_use_case.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_intent.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_status.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase _useCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;
  final ImagePicker _imagePicker = ImagePicker();
  File _imageFile = File('');
  @factoryMethod
  EditProfileCubit(this._useCase, this._uploadPhotoUseCase)
    : super(const EditProfileState());
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late GlobalKey<FormState> formKey;
  Future<void> doIntent({required EditProfileIntent intent}) async {
    switch (intent) {
      case InitializeEditProfile():
        _onInit();
        break;
      case EnterThePassword():
        _enterThePassword();
        break;
      case SubmitEditProfile():
        await _submitEditProfile();
        break;
      case IsObscure():
        _isObscure();
        break;
      case UploadPhotoIntent():
        await _pickAndUploadPhoto();
    }
  }

  void _onInit() {
    formKey = GlobalKey<FormState>();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    firstNameController.addListener(_checkFormValidation);
    lastNameController.addListener(_checkFormValidation);
    emailController.addListener(_checkFormValidation);
    phoneController.addListener(_checkFormValidation);
    passwordController.addListener(_checkFormValidation);
  }

  void _enterThePassword() {
    if (state.isObscure) {
      passwordController.text = '';
    }
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  bool _isObscure() {
    if (state.isObscure) {
      passwordController.text = '';
    }
    return state.isObscure;
  }

  void _checkFormValidation() {
    final isValid =
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;

    emit(
      state.copyWith(
        isFormValid: isValid,
        editProfileStatus: const StateStatus.initial(),
      ),
    );
  }

  Future<DriverDataEntity?> _submitEditProfile() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(editProfileStatus: const StateStatus.loading()));
      final result = await _useCase.editProfile(
        EditProfileRequestEntity(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          phone: phoneController.text,
          password: passwordController.text,
        ),
      );

      switch (result) {
        case Success<DriverDataEntity>():
          final driverData = result.data;
          FloweryDriverMethodHelper.driverData = driverData;
          emit(
            state.copyWith(editProfileStatus: const StateStatus.success(null)),
          );
          try {
            final profileCubit = getIt<ProfileCubit>();
            await profileCubit.doIntent(GetUserProfileDataIntent());
          } catch (_) {}
          return driverData;

        case Failure<DriverDataEntity>():
          emit(
            state.copyWith(
              editProfileStatus: StateStatus.failure(result.responseException),
            ),
          );
          return null;
      }
    }
    return null;
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    return super.close();
  }

  Future<void> _pickAndUploadPhoto() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 8,
      );

      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        await _uploadProfilePhoto(_imageFile);
      }
    } catch (e) {
      emit(
        state.copyWith(
          uploadPhotoState: StateStatus.failure(
            ResponseException(
              message: '${AppText.pickingImageFailureMessage.tr()} $e',
            ),
          ),
        ),
      );
    }
  }

  Future<void> _uploadProfilePhoto(File photoFile) async {
    emit(state.copyWith(uploadPhotoState: const StateStatus.loading()));

    final result = await _uploadPhotoUseCase.invoke(photoFile: photoFile);

    switch (result) {
      case Success<UploadPhotoResponseEntity>():
        emit(state.copyWith(uploadPhotoState: StateStatus.success(photoFile)));
      case Failure<UploadPhotoResponseEntity>():
        emit(
          state.copyWith(
            uploadPhotoState: StateStatus.failure(result.responseException),
          ),
        );
    }
  }
}
