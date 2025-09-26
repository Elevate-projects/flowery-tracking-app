import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResendCodeRow extends StatelessWidget {
  const ResendCodeRow({
    super.key,
    required this.onResend,
    required this.isDisabled,
  });

  final VoidCallback? onResend;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppText.notReceivedCodeStatement.tr(),
          style: theme.labelLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        const RSizedBox(width: 4),
        InkWell(
          onTap: isDisabled ? null : onResend,
          child: Text(
            AppText.resendWord.tr(),
            style: theme.labelLarge?.copyWith(
              color: isDisabled
                  ? Colors.grey
                  : Theme.of(context).colorScheme.primary,
              decoration: TextDecoration.underline,
              decorationColor: isDisabled
                  ? Colors.grey
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
