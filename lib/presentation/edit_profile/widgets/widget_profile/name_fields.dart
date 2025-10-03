import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NameFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const NameFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: firstNameController,
              label: AppText.firstName.tr(),
            ),
          ),
          const RSizedBox(width: 17),
          Expanded(
            child: CustomTextFormField(
              controller: lastNameController,
              label: AppText.lastName.tr(),
            ),
          ),
        ],
      ),
    );
  }
}
