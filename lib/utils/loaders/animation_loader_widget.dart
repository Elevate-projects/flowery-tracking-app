import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AnimationLoaderWidget extends StatelessWidget {
  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionWidget,
    this.style,
  });

  final String text;
  final String animation;
  final bool showAction;
  final Widget? actionWidget;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Lottie.asset(
              animation,
              width: ScreenUtil().screenWidth * 0.8,
            ),
          ),
          RPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              text.tr(),
              style:
                  style ??
                  theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            ),
          ),
          const RSizedBox(height: 24),
          Visibility(
            visible: showAction,
            child: actionWidget ?? const RSizedBox(),
          ),
        ],
      ),
    );
  }
}
