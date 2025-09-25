import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) => CustomElevatedButton(
        key: const Key("login_button"),
        onPressed: state.isValidToLogin
            ? () async => await loginCubit.doIntent(
                intent: LoginWithEmailAndPasswordIntent(),
              )
            : () => loginCubit.doIntent(intent: EnableValidationIntent()),
        buttonTitle: AppText.continueText,
        backgroundColor: state.isValidToLogin
            ? theme.colorScheme.primary
            : AppColors.white[60],
      ),
    );
  }
}
