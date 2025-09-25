import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeTextFiledWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        PinCodeTextField(
          controller: verificationController,
          length: 6,
          keyboardType: TextInputType.number,
          appContext: context,
          animationType: AnimationType.scale,
          enableActiveFill: true,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8.r),
            activeFillColor: Theme.of(context).colorScheme.onPrimary,
            selectedFillColor: Theme.of(context).colorScheme.onPrimary,
            inactiveFillColor: Theme.of(context).colorScheme.onPrimary,
            inactiveColor: isError ? Colors.red : Colors.transparent,
            selectedColor: isError ? Colors.red : Colors.transparent,
            activeColor: isError ? Colors.red : Colors.transparent,
            borderWidth: isError ? 1.5 : 0,
          ),
          onCompleted: (value) => onCompleted(value),
          onSubmitted: (value) => onSubmitted(value),
        ),
        if (isError)
          Row(
            children: [
              const Spacer(),
              Icon(Icons.error, color: Colors.red, size: 18.sp),
              const RSizedBox(width: 4),
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
