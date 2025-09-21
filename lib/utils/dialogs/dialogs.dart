import 'package:flowery_tracking_app/utils/dialogs/custom_dialog_content.dart';
import 'package:flutter/material.dart';

abstract class Dialogs {
  static Future customDialog({
    required BuildContext context,
    List<Widget>? actions,
    Widget? content,
    bool isBarrierDismissible = true,
  }) {
    return showDialog(
      barrierDismissible: isBarrierDismissible,
      useSafeArea: true,
      context: context,
      builder: (context) =>
          CustomDialogContent(content: content, actions: actions),
    );
  }
}
