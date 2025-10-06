import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsCustomContainer extends StatelessWidget {
  const OrderDetailsCustomContainer({
    super.key,
    required this.title,
    required this.suffixTitle,
  });
  final String title;
  final String suffixTitle;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.25),
            blurStyle: BlurStyle.outer,
            blurRadius: 4.r,
          ),
        ],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title.tr(),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSecondary,
                fontFamily: "Roboto",
              ),
            ),
          ),
          Text(
            suffixTitle,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: "Roboto",
              color: theme.colorScheme.shadow,
            ),
          ),
        ],
      ),
    );
  }
}
