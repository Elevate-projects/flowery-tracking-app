import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/entities/edit_profile/edit_profile_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_intent.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_status.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase _useCase;
  @factoryMethod
  EditProfileCubit(this._useCase) : super(const EditProfileState());
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
    final isValid = firstNameController.text.isNotEmpty &&
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
            state.copyWith(
              editProfileStatus: const StateStatus.success(null),
            ),
          );
          try {
            final profileCubit = getIt<ProfileCubit>();
            await profileCubit.doIntent(GetUserProfileDataIntent());
          } catch (_) {}
          return driverData;

        case Failure<DriverDataEntity>():
          emit(
            state.copyWith(
              editProfileStatus: StateStatus.failure(
                result.responseException,
              ),
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
}
