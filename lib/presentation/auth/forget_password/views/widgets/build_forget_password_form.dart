import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views_model/forget_password_and_resend_code_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_tracking_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildForgetPasswordForm extends StatelessWidget {
  const BuildForgetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final cubit = BlocProvider.of<ForgetPasswordAndResendCodeCubit>(context);
    return BlocBuilder<
      ForgetPasswordAndResendCodeCubit,
      ForgetPasswordAndResendCodeState
    >(
      builder: (context, state) {
        return Padding(
          padding: REdgeInsets.all(16),
          child: Form(
            key: cubit.formKey,
            autovalidateMode: cubit.state.autoValidateMode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppText.forgetPasswordTitle.tr(),
                  style: theme.headlineSmall,
                ),
                const RSizedBox(height: 15),
                Text(
                  textAlign: TextAlign.center,
                  AppText.forgetPasswordSubTitle.tr(),
                  style: theme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.shadow,
                  ),
                ),
                SizedBox(height: 30.h),
                CustomTextFormField(
                  label: AppText.email.tr(),
                  controller: cubit.emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: AppText.emailHint,
                  validator: (value) =>
                      Validations.emailValidation(email: value),
                ),
                const RSizedBox(height: 50),
                CustomElevatedButton(
                  onPressed: () {
                    cubit.doIntent(
                      OnConfirmEmailClickIntent(
                        request: ForgetPasswordAndResendCodeRequestEntity(
                          email: cubit.emailController.text.trim(),
                        ),
                      ),
                    );
                  },
                  buttonTitle: AppText.confirmWord.tr(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
