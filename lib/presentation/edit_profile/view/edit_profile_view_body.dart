import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view/gender_viwe.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_intent.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_status.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/widget_profile/name_fields.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/widget_profile/profile_image.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
             AppIcons.notification,
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
      body: BlocListener<EditProfileCubit, EditProfileState>(
        listenWhen: (previous, current) =>
        current.editProfileStatus.isFailure ||
            current.editProfileStatus.isSuccess ||
            current.editProfileStatus.isLoading,
        listener: (context, state) {
          if (state.editProfileStatus.isLoading) {
          } else if (state.editProfileStatus.isFailure) {
            Loaders.showErrorMessage(
                message: AppText.failure.tr(), context: context);
          } else if (state.editProfileStatus.isSuccess) {
            Loaders.showSuccessMessage(
              message: AppText.success.tr(),
              context: context,
            );
          }
        },
        child: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            if (state.editProfileStatus.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    const RSizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfileImage(imageUrl: state.driverData?.photo),
                      ],
                    ),
                    const RSizedBox(height: 24),
                    NameFields(
                      firstNameController: cubit.firstNameController,
                      lastNameController: cubit.lastNameController,
                    ),
                    const RSizedBox(height: 24),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextFormField(
                        controller: cubit.emailController,
                        label: AppText.email.tr(),
                      ),
                    ),
                    const RSizedBox(height: 24),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextFormField(
                        controller: cubit.phoneController,
                        label: AppText.phone.tr(),
                      ),
                    ),
                    const RSizedBox(height: 24),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: cubit.passwordController,
                              label: AppText.password.tr(),
                              obscureText: state.isObscure,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  cubit.onIntent(EnterThePassword());
                                },
                                child: Padding(
                                  padding: REdgeInsets.only(right: 8),
                                  child: Text(
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
                    ),
                    const RSizedBox(height: 24),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: const GenderView(),
                    ),
                    const RSizedBox(height: 40),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: CustomElevatedButton(
                          onPressed: state.isFormValid
                              ? () {
                            cubit.onIntent(SubmitEditProfile());
                          }
                              : null,
                        buttonTitle: AppText.update.tr(),
                      ),
                    )
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
