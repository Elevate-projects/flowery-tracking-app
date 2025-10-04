import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonTitle,
    this.backgroundColor,
    this.height,
    this.width,
    this.titleStyle,
    this.borderColor,
    this.isText = true,
    this.child,
  });

  final void Function()? onPressed;
  final String buttonTitle;
  final Color? backgroundColor;
  final double? height, width;
  final TextStyle? titleStyle;
  final Color? borderColor;
  final bool isText;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.primary,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        minimumSize: Size(width ?? ScreenUtil().screenWidth, height ?? 48.h),
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
      ),
      onPressed: onPressed,
      child: isText
          ? FittedBox(
              child: Text(
                buttonTitle.tr(),
                style: titleStyle ?? Theme.of(context).textTheme.labelLarge,
              ),
            )
          : child,
    );
  }
}
