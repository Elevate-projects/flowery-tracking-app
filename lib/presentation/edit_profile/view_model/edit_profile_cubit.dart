import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/requests/adit_profile/edit_profile_request.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_intent.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_status.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase _useCase;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;

  @factoryMethod
  EditProfileCubit(this._useCase) : super(const EditProfileState()) {
    formKey = GlobalKey<FormState>();

    final user = FloweryDriverMethodHelper.driverData;

    firstNameController = TextEditingController(text: user?.firstName ?? "");
    lastNameController = TextEditingController(text: user?.lastName ?? "");
    emailController = TextEditingController(text: user?.email ?? "");
    phoneController = TextEditingController(text: user?.phone ?? "");
    passwordController = TextEditingController();

    // Listen to changes for form validation
    firstNameController.addListener(validateForm);
    lastNameController.addListener(validateForm);
    emailController.addListener(validateForm);
    phoneController.addListener(validateForm);
    passwordController.addListener(validateForm);
  }

  Future<void> doIntent({required EditProfileIntent intent}) async {
    switch (intent) {
      case EnterThePassword():
        _enterThePassword();
        break;
      default:
        break;
    }
  }

  void _enterThePassword() {
    emit(
      state.copyWith(
        isObscure: !state.isObscure,
        editProfileStatus: const StateStatus.initial(),
      ),
    );
  }

  void validateForm() {
    final isValid = firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;

    emit(state.copyWith(isFormValid: isValid));
  }

  Future<void> editProfile() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      emit(state.copyWith(editProfileStatus: const StateStatus.loading()));

      final userData = await _useCase.editProfile(
        EditProfileRequestModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          phone: phoneController.text,
          password: passwordController.text,
        ),
      );

      switch (userData) {
        case Success<DriverDataEntity>(:final data):
          emit(
            state.copyWith(
              editProfileStatus: const StateStatus.success(null),
              driverData: data,
            ),
          );
          break;

        case Failure<DriverDataEntity>():
          emit(
            state.copyWith(
              editProfileStatus: StateStatus.failure(userData.responseException),
            ),
          );
          break;
      }
    }
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
