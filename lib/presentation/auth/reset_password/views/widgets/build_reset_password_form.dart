import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views/widgets/reset_password_title_and_sub_title.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views_model/reset_password_intent.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_tracking_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildResetPasswordForm extends StatelessWidget {
  const BuildResetPasswordForm({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ResetPasswordCubit>(context);
    return Padding(
      padding: REdgeInsets.all(16),
      child: Form(
        key: cubit.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ResetPasswordTitleAndSubTitle(),
            const RSizedBox(height: 30),
            CustomTextFormField(
              label: AppText.password,
              controller: cubit.passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              hintText: AppText.passwordHint,
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
                password: cubit.passwordController.text,
                confirmPassword: value,
              ),
            ),
            const SizedBox(height: 50),
            CustomElevatedButton(
              onPressed: () {
                BlocProvider.of<ResetPasswordCubit>(context).doIntent(
                  OnResetPasswordIntent(
                    request: ResetPasswordRequestEntity(
                      email: email,
                      newPassword: cubit.confirmPasswordController.text,
                    ),
                  ),
                );
              },
              buttonTitle: AppText.confirmWord,
            ),
          ],
        ),
      ),
    );
  }
}
