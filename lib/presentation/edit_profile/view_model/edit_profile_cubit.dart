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

  // Private controllers
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;

  @factoryMethod
  EditProfileCubit(this._useCase) : super(const EditProfileState()) {
    _formKey = GlobalKey<FormState>();
    final user = FloweryDriverMethodHelper.driverData;

    _firstNameController = TextEditingController(text: user?.firstName ?? '');
    _lastNameController = TextEditingController(text: user?.lastName ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _passwordController = TextEditingController();

    _firstNameController.addListener(_validateForm);
    _lastNameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);

    _validateForm();
  }

  /// Public API for UI
  Future<void> onIntent({required EditProfileIntent intent}) async {
    switch (intent) {
      case SubmitEditProfile():
        await _submitEditProfile();
        break;
      case IsObscure():
        _togglePasswordVisibility();
        break;
      case InitializeEditProfile():
        _validateForm();
        break;
      case EnterThePassword():
        _togglePasswordVisibility();
        break;
    }
  }

  void _togglePasswordVisibility() {
    // Clear password field when toggling visibility for security
    if (state.isObscure) {
      _passwordController.text = '';
    }
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  Future<void> _submitEditProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(editProfileStatus: const StateStatus.loading()));
      final result = await _useCase.editProfile(
        EditProfileRequestEntity(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
        ),
      );

      switch (result) {
        case Success<DriverDataEntity>(:final data):
          FloweryDriverMethodHelper.driverData = data;
          emit(
            state.copyWith(
              editProfileStatus: const StateStatus.success(null),
            ),
          );
          try {
            final profileCubit = getIt<ProfileCubit>();
            await profileCubit.doIntent(GetUserProfileDataIntent());
          } catch (_) {}
          break;

        case Failure<DriverDataEntity>():
          emit(
            state.copyWith(
              editProfileStatus: StateStatus.failure(
                result.responseException,
              ),
            ),
          );
          break;
      }
    }
  }

  void _validateForm() {
    final isValid = _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;

    if (state.isFormValid != isValid) {
      emit(state.copyWith(isFormValid: isValid));
    }
  }

  // Public getters for UI binding
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get passwordController => _passwordController;

  @override
  Future<void> close() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    return super.close();
  }
}
