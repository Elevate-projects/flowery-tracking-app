import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeTextFiledWidget extends StatefulWidget {
  const PinCodeTextFiledWidget({
    super.key,
    required this.verificationController,
    required this.onCompleted,
    required this.onSubmitted,
    required this.isError,
  });

  final TextEditingController verificationController;
  final ValueChanged onCompleted;
  final ValueChanged onSubmitted;
  final bool isError;

  @override
  State<PinCodeTextFiledWidget> createState() => _PinCodeTextFiledWidgetState();
}

class _PinCodeTextFiledWidgetState extends State<PinCodeTextFiledWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PinCodeTextField(
          controller: widget.verificationController,
          length: 6,
          keyboardType: TextInputType.number,
          appContext: context,
          animationType: AnimationType.scale,
          enableActiveFill: true,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8.r),
            activeFillColor: AppColors.lightPink,
            selectedFillColor: AppColors.lightPink,
            inactiveFillColor: AppColors.lightPink,
            inactiveColor: widget.isError ? Colors.red : Colors.transparent,
            selectedColor: widget.isError ? Colors.red : Colors.transparent,
            activeColor: widget.isError ? Colors.red : Colors.transparent,
            borderWidth: widget.isError ? 1.5 : 0,
          ),
          onCompleted: (value) => widget.onCompleted(value),
          onSubmitted: (value) => widget.onSubmitted(value),
        ),
        if (widget.isError)
          Row(
            children: [
              const Spacer(),
              Icon(Icons.error, color: Colors.red, size: 18.sp),
              SizedBox(width: 4.w),
              Text(
                AppText.invalidCode.tr(),
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.red),
              ),
            ],
          ),
      ],
    );
  }
}
