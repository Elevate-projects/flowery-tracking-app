import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetSelectionItem extends StatelessWidget {
  const BottomSheetSelectionItem({
    super.key,
    required this.itemTitle,
    required this.radioItem,
    this.onTap,
  });
  final String itemTitle;
  final Widget radioItem;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ScreenUtil().screenWidth,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onSecondary.withValues(alpha: 0.1),
              blurStyle: BlurStyle.outer,
              blurRadius: 5.r,
            ),
          ],
        ),
        padding: REdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  itemTitle.tr(),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            const RSizedBox(width: 12),
            radioItem,
          ],
        ),
      ),
    );
  }
}
