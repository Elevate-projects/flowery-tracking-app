import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views/widgets/forget_password_button.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RememberMeAndForgetPassRow extends StatelessWidget {
  const RememberMeAndForgetPassRow({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) => Checkbox(
                  value: state.rememberMe,
                  onChanged: (_) async => await loginCubit.doIntent(
                    intent: ToggleRememberMeIntent(),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  side: BorderSide(
                    width: 2.r,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async =>
                    await loginCubit.doIntent(intent: ToggleRememberMeIntent()),
                child: Text(
                  AppText.rememberMe.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        const RSizedBox(width: 12),
        const ForgetPasswordButton(),
      ],
    );
  }
}
