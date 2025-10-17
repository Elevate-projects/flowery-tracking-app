import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';
import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_state.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/country_item.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/gender_section.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_dropdown_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_tracking_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApplyForm extends StatelessWidget {
  const ApplyForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final applyCubit = BlocProvider.of<ApplyCubit>(context);
    return BlocBuilder<ApplyCubit, ApplyState>(
      builder: (context, state) => Form(
        key: applyCubit.applyFormKey,
        autovalidateMode: state.autoValidateMode,
        child: Column(
          children: [
            BlocBuilder<ApplyCubit, ApplyState>(
              buildWhen: (previous, current) =>
                  current.countryStatus.isLoading ||
                  current.countryStatus.isSuccess,
              builder: (context, state) => CustomDropdownButton<CountryEntity>(
                key: const Key("countryDropdown"),
                hint: AppText.countryHint.tr(),
                value: state.selectedCountry,
                dropdownItems: state.countryStatus.data
                    ?.map(
                      (country) => DropdownMenuItem<CountryEntity>(
                        value: country,
                        child: CountryItem(countryData: country),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  applyCubit.doIntent(
                    intent: ChangeCountryIntent(selectedCountry: value),
                  );
                },
              ),
            ),
            const RSizedBox(height: 25),
            CustomTextFormField(
              key: const Key("firstLegalName"),
              controller: applyCubit.firstLegalNameController,
              label: AppText.firstLegalName.tr(),
              hintText: AppText.firstLegalNameHint.tr(),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              validator: (value) => Validations.fieldValidation(value: value),
            ),
            const RSizedBox(height: 25),
            CustomTextFormField(
              key: const Key("secondLegalName"),
              controller: applyCubit.secondLegalNameController,
              label: AppText.secondLegalName.tr(),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              hintText: AppText.secondLegalNameHint.tr(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              validator: (value) => Validations.fieldValidation(value: value),
            ),
            const RSizedBox(height: 25),
            CustomDropdownButton<VehicleEntity>(
              key: const Key("vehicleDropdown"),
              hint: AppText.vehicleTypeHint.tr(),
              value: state.selectedVehicle,
              dropdownItems: state.vehicleStatus.data
                  ?.map(
                    (vehicle) => DropdownMenuItem<VehicleEntity>(
                      value: vehicle,
                      child: Text(
                        vehicle.type,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                applyCubit.doIntent(
                  intent: ChangeVehicleIntent(selectedVehicle: value),
                );
              },
            ),
            const RSizedBox(height: 25),
            CustomTextFormField(
              key: const Key("vehicleNumber"),
              controller: applyCubit.vehicleNumberController,
              label: AppText.vehicleNumber.tr(),
              hintText: AppText.vehicleNumberHint.tr(),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              validator: (value) => Validations.fieldValidation(value: value),
            ),
            const RSizedBox(height: 25),
            GestureDetector(
              onTap: () async => await applyCubit.doIntent(
                intent: const PickVehicleLicenseImageIntent(),
              ),
              child: CustomTextFormField(
                key: const Key("vehicleLicense"),
                controller: applyCubit.vehicleLicenseController,
                label: AppText.vehicleLicense.tr(),
                hintText: AppText.vehicleLicenseHint.tr(),
                enabled: false,
                suffixIcon: RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(
                    AppIcons.upload2,
                    fit: BoxFit.contain,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                validator: (value) => Validations.fieldValidation(value: value),
              ),
            ),
            const RSizedBox(height: 25),
            CustomTextFormField(
              key: const Key("email"),
              controller: applyCubit.emailController,
              label: AppText.email.tr(),
              hintText: AppText.emailHint.tr(),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              validator: (value) => Validations.emailValidation(email: value),
            ),
            const RSizedBox(height: 25),
            CustomTextFormField(
              key: const Key("phoneNumber"),
              controller: applyCubit.phoneNumberController,
              label: AppText.phoneNumber.tr(),
              hintText: AppText.phoneNumberHint.tr(),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              validator: (value) =>
                  Validations.phoneValidation(phoneNumber: value),
            ),
            const RSizedBox(height: 25),
            CustomTextFormField(
              key: const Key("idNumber"),
              controller: applyCubit.idNumberController,
              label: AppText.idNumber.tr(),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              hintText: AppText.idNumberHint.tr(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              validator: (value) => Validations.fieldValidation(value: value),
            ),
            const RSizedBox(height: 25),
            GestureDetector(
              onTap: () async =>
                  await applyCubit.doIntent(intent: const PickIdImageIntent()),
              child: CustomTextFormField(
                key: const Key("idImage"),
                controller: applyCubit.idImageController,
                label: AppText.idImage.tr(),
                hintText: AppText.idImageHint.tr(),
                enabled: false,
                suffixIcon: RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(
                    AppIcons.upload2,
                    fit: BoxFit.contain,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                validator: (value) => Validations.fieldValidation(value: value),
              ),
            ),
            const RSizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    key: const Key("password"),
                    controller: applyCubit.passwordController,
                    label: AppText.password.tr(),
                    hintText: AppText.passwordHint2.tr(),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    validator: (value) =>
                        Validations.passwordValidation(password: value),
                    suffixIcon: IconButton(
                      onPressed: () {
                        applyCubit.doIntent(
                          intent: const ToggleObscurePasswordIntent(),
                        );
                      },
                      icon: Icon(
                        state.isObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 22.r,
                      ),
                    ),
                    obscuringCharacter: "*",
                    obscureText: state.isObscure,
                  ),
                ),
                const RSizedBox(width: 16),
                Expanded(
                  child: CustomTextFormField(
                    key: const Key("confirmPassword"),
                    controller: applyCubit.confirmPasswordController,
                    label: AppText.confirmPassword.tr(),
                    hintText: AppText.confirmPassword.tr(),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: IconButton(
                      onPressed: () {
                        applyCubit.doIntent(
                          intent: const ToggleConfirmObscurePasswordIntent(),
                        );
                      },
                      icon: Icon(
                        state.isObscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 22.r,
                      ),
                    ),
                    obscuringCharacter: "*",
                    obscureText: state.isObscureConfirm,
                    validator: (value) => Validations.confirmPasswordValidation(
                      confirmPassword: value,
                      password: applyCubit.passwordController.text.trim(),
                    ),
                  ),
                ),
              ],
            ),
            const RSizedBox(height: 25),
            const GenderSection(),
          ],
        ),
      ),
    );
  }
}
