import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flutter/material.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(RouteNames.forgetPassword);
      },
      child: Text(
        AppText.forgetPassword.tr(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSecondary,
          decoration: TextDecoration.underline,
          decorationColor: Theme.of(context).colorScheme.onSecondary,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
