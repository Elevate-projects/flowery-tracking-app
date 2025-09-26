import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';
import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/country_item.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/widgets/gender_section.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views_body/apply_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views_body/apply_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views_body/apply_state.dart';
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
                hint: AppText.countryHint,
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
              controller: applyCubit.firstLegalNameController,
              label: AppText.firstLegalName,
              hintText: AppText.firstLegalNameHint,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              validator: (value) => Validations.fieldValidation(value: value),
            ),
            const RSizedBox(height: 25),
            CustomTextFormField(
              controller: applyCubit.secondLegalNameController,
              label: AppText.secondLegalName,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              hintText: AppText.secondLegalNameHint,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              validator: (value) => Validations.fieldValidation(value: value),
            ),
            const RSizedBox(height: 25),
            CustomDropdownButton<VehicleEntity>(
              hint: AppText.vehicleTypeHint,
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
              controller: applyCubit.vehicleNumberController,
              label: AppText.vehicleNumber,
              hintText: AppText.vehicleNumberHint,
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
                controller: applyCubit.vehicleLicenseController,
                label: AppText.vehicleLicense,
                hintText: AppText.vehicleLicenseHint,
                enabled: false,
                suffixIcon: RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(AppIcons.upload, fit: BoxFit.contain),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                validator: (value) => Validations.fieldValidation(value: value),
              ),
            ),
            const RSizedBox(height: 25),
            CustomTextFormField(
              controller: applyCubit.emailController,
              label: AppText.email,
              hintText: AppText.emailHint,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              validator: (value) => Validations.emailValidation(email: value),
            ),
            const RSizedBox(height: 25),
            CustomTextFormField(
              controller: applyCubit.phoneNumberController,
              label: AppText.phoneNumber,
              hintText: AppText.phoneNumberHint,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              validator: (value) =>
                  Validations.phoneValidation(phoneNumber: value),
            ),
            const RSizedBox(height: 25),
            CustomTextFormField(
              controller: applyCubit.idNumberController,
              label: AppText.idNumber,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              hintText: AppText.idNumberHint,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              validator: (value) => Validations.fieldValidation(value: value),
            ),
            const RSizedBox(height: 25),
            GestureDetector(
              onTap: () async =>
                  await applyCubit.doIntent(intent: const PickIdImageIntent()),
              child: CustomTextFormField(
                controller: applyCubit.idImageController,
                label: AppText.idImage,
                hintText: AppText.idImageHint,
                enabled: false,
                suffixIcon: RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(AppIcons.upload, fit: BoxFit.contain),
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
                    controller: applyCubit.passwordController,
                    label: AppText.password,
                    hintText: AppText.passwordHint2,
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
                    controller: applyCubit.confirmPasswordController,
                    label: AppText.confirmPassword,
                    hintText: AppText.confirmPassword,
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
