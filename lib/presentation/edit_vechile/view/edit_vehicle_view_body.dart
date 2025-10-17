import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view_model/edit_vehicle_cubit.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view_model/edit_vehicle_intent.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view_model/edit_vehicle_status.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_dropdown_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditVehicleViewBody extends StatelessWidget {
  const EditVehicleViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<EditVehicleCubit>();
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: Text(AppText.editVehicle.tr())),
      body: BlocListener<EditVehicleCubit, EditVehicleStatus>(
        listenWhen: (previous, current) =>
            current.editVehicleStatus.isFailure ||
            current.editVehicleStatus.isSuccess ||
            current.editVehicleStatus.isLoading,
        listener: (context, state) {
          if (state.editVehicleStatus.isLoading) {
            // Optional: Show a loader overlay
          } else if (state.editVehicleStatus.isFailure) {
            Loaders.showErrorMessage(
              message: AppText.failure.tr(),
              context: context,
            );
          } else if (state.editVehicleStatus.isSuccess) {
            Loaders.showSuccessMessage(
              message: AppText.success.tr(),
              context: context,
            );
          }
        },
        child: BlocBuilder<EditVehicleCubit, EditVehicleStatus>(
          builder: (context, state) {
            if (state.editVehicleStatus.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RSizedBox(height: 24),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: CustomDropdownButton<String>(
                        hint: AppText.vehicleType.tr(),
                        value: state.selectedVehicleType,
                        dropdownItems: state.vehicleTypes
                            .map(
                              (type) => DropdownMenuItem<String>(
                                value: type,
                                child: Text(
                                  type,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.onSecondary,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            cubit.onIntent(SelectVehicleType(value));
                          }
                        },
                        buttonDecoration: BoxDecoration(
                          border: Border.all(color: theme.colorScheme.shadow),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        buttonPadding:
                            REdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        icon: Transform.rotate(
                          angle: 180 * (3.141592653589793 / 350),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: theme.colorScheme.onSecondary,
                            size: 22,
                          ),
                        ),
                        dropdownHeight: 220.h,
                        dropdownDecoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    const RSizedBox(height: 24),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextFormField(
                        controller: cubit.vehicleNumberController,
                        label: AppText.vehicleNumber.tr(),
                        hintText: AppText.enterVehicleNumber.tr(),
                      ),
                    ),
                    const RSizedBox(height: 24),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextFormField(
                        isReadOnly: true,
                        controller: cubit.vehicleLicenseController,
                        label: AppText.vehicleLicense.tr(),
                        hintText: AppText.enterVehicleLicense.tr(),
                        suffixIcon: Image.asset(
                          AppIcons.upload,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ),
                    const RSizedBox(height: 40),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: CustomElevatedButton(
                        onPressed: state.isFormValid
                            ? () {
                                cubit.onIntent(SubmitEditVehicle());
                              }
                            : null,
                        buttonTitle: AppText.update.tr(),
                      ),
                    ),
                    const RSizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
