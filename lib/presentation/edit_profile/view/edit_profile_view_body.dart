import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_intent.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_status.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/gender_section.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/widget_profile/name_fields.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/widget_profile/profile_image.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<EditProfileCubit>();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(AppText.editProfile.tr()),
      ),
      body: BlocListener<EditProfileCubit, EditProfileState>(
        listenWhen: (previous, current) =>
        current.editProfileStatus != previous.editProfileStatus,
          listener: (context, state) {
            if (state.editProfileStatus.isLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              if (state.editProfileStatus.isFailure) {
                Loaders.showErrorMessage(
                    message: state.editProfileStatus.error?.message ?? "", context: context
                );
              } else if (state.editProfileStatus.isSuccess) {
                Loaders.showSuccessMessage(
                  message: AppText.success.tr(),
                  context: context,
                );
              }
            }
          },
        child: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  const RSizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileImage(imageUrl: context.watch<EditProfileCubit>().state.driverData?.photo),
                    ],
                  ),
                  const RSizedBox(height: 24),
                  NameFields(
                    firstNameController: cubit.firstNameController,
                    lastNameController: cubit.lastNameController,
                  ),
                  const RSizedBox(height: 24),
                  CustomTextFormField(
                    controller: cubit.emailController,
                    label: AppText.email.tr(),
                  ),
                  const RSizedBox(height: 24),
                  CustomTextFormField(
                    controller: cubit.phoneController,
                    label: AppText.phone.tr(),
                  ),
                  const RSizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: cubit.passwordController,
                          label: AppText.password.tr(),
                          obscureText: context.watch<EditProfileCubit>().state.isObscure,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              cubit.doIntent(intent: EnterThePassword());
                            },
                            child: Padding(
                              padding: REdgeInsets.only(right: 8),
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                AppText.changePassword.tr(),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.shadow,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const RSizedBox(height: 24),
                  GenderSection(),
                  const RSizedBox(height: 40),
                  BlocBuilder<EditProfileCubit, EditProfileState>(
                    buildWhen: (previous, current) =>
                    previous.isFormValid != current.isFormValid,
                    builder: (context, state) {
                      return CustomElevatedButton(
                        onPressed: state.isFormValid
                            ? () => cubit.doIntent(intent: SubmitEditProfile())
                            : null,
                        buttonTitle: AppText.update.tr(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
