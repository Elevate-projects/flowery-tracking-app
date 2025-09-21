import 'package:flowery_tracking_app/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class FullScreenLoader {
  static void openLoadingDialog({
    required String text,
    required String animation,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: Theme.of(context).colorScheme.shadow,
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().scaleHeight,
          child: Column(
            children: [
              const RSizedBox(height: 200),
              AnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  static void stopLoading({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}
