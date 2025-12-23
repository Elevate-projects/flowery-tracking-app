import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view/widgets/gender_section.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view/widgets/widget_profile/name_fields.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view/widgets/widget_profile/profile_image.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_intent.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_status.dart';
<<<<<<< HEAD
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_intent.dart';
=======
>>>>>>> 6c822904059ec14f2229a729dbe759badebe7731
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key,required this.profileCubit});
  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<EditProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
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
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          } else {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            if (state.editProfileStatus.isFailure) {
              Loaders.showErrorMessage(
                message: state.editProfileStatus.error?.message ?? "",
                context: context,
              );
            } else if (state.editProfileStatus.isSuccess) {
             Navigator.pop(context);
             profileCubit.doIntent(GetUserProfileDataIntent());
            }
            if (state.uploadPhotoState.isSuccess){
                profileCubit.doIntent(GetUserProfileDataIntent());
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
                  ProfileImage(
                    imageUrl: context
                        .watch<EditProfileCubit>()
                        .state
                        .driverData
                        ?.photo,
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
                        child: Stack(
                          children: [
                            IgnorePointer(
                              child: CustomTextFormField(
<<<<<<< HEAD
=======
                                controller: cubit.passwordController,
>>>>>>> 6c822904059ec14f2229a729dbe759badebe7731
                                label: AppText.password.tr(),
                                hintText: "★★★★★★",
                                hintStyle: theme.textTheme.labelLarge?.copyWith(
                                  color: AppColors.black,
                                ),
                                isReadOnly: true,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                obscuringCharacter: '★',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                obscureText: true,
<<<<<<< HEAD
                              
=======
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    cubit.doIntent(intent: EnterThePassword());
                                  },
                                ),
>>>>>>> 6c822904059ec14f2229a729dbe759badebe7731
                              ),
                            ),
                            PositionedDirectional(
                              end: 16.r,
                              top: 20.r,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(
                                    context,
                                  ).pushNamed(RouteNames.profileResetPassword);
                                },
                                child: Text(
                                  AppText.changePassword.tr(),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
