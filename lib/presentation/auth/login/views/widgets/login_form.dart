import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_tracking_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) => Form(
        key: loginCubit.loginFormKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: loginCubit.emailController,
              label: AppText.email,
              hintText: AppText.emailHint,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) => Validations.emailValidation(email: value),
              enabled: !state.loginStatus.isLoading,
              onChanged: (_) =>
                  loginCubit.doIntent(intent: CheckFieldsValidationIntent()),
            ),
            const RSizedBox(height: 24),
            CustomTextFormField(
              controller: loginCubit.passwordController,
              label: AppText.password,
              hintText: AppText.passwordHint,
              suffixIcon: IconButton(
                onPressed: () {
                  loginCubit.doIntent(intent: ToggleObscurePasswordIntent());
                },
                icon: Icon(
                  state.isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: 22.r,
                ),
              ),
              obscuringCharacter: "*",
              obscureText: state.isObscure,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) =>
                  Validations.passwordValidation(password: value),
              enabled: !state.loginStatus.isLoading,
              onChanged: (_) =>
                  loginCubit.doIntent(intent: CheckFieldsValidationIntent()),
            ),
          ],
        ),
      ),
    );
  }
}
