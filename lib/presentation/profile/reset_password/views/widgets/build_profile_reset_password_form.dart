import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/requests/profile_reset_password/profile_reset_password_entity.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views_model/profile_reset_password_intent.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_tracking_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildProfileResetPasswordForm extends StatelessWidget {
  const BuildProfileResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileResetPasswordCubit>(context);
    return RPadding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: cubit.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              label: AppText.currentPassword,
              controller: cubit.currentPasswordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              hintText: AppText.currentPassword,
              textInputAction: TextInputAction.next,
              validator: (value) =>
                  Validations.passwordValidation(password: value),
            ),
            const RSizedBox(height: 25),
            CustomTextFormField(
              label: AppText.newPassword,
              controller: cubit.newPasswordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              hintText: AppText.newPassword,
              textInputAction: TextInputAction.next,
              validator: (value) =>
                  Validations.passwordValidation(password: value),
            ),
            const RSizedBox(height: 25),
            CustomTextFormField(
              label: AppText.confirmPassword,
              controller: cubit.confirmPasswordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              hintText: AppText.confirmPasswordHint,
              textInputAction: TextInputAction.next,
              validator: (value) => Validations.confirmPasswordValidation(
                password: cubit.newPasswordController.text,
                conformPassword: value,
              ),
            ),
            const SizedBox(height: 50),
            CustomElevatedButton(
              onPressed: () {
                BlocProvider.of<ProfileResetPasswordCubit>(context).doIntent(
                  OnProfileResetPasswordIntent(
                    request: ProfileResetPasswordRequestEntity(
                      password: cubit.currentPasswordController.text,
                      newPassword: cubit.confirmPasswordController.text,
                    ),
                  ),
                );
              },
              buttonTitle: AppText.update,
            ),
          ],
        ),
      ),
    );
  }
}
