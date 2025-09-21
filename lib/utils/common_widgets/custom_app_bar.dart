import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleStyle,
    this.automaticallyImplyLeading = false,
    this.centerTitle = false,
    this.backgroundColor,
    this.leading,
    this.leadingWidth,
    this.actions,
    this.isTitleWidget = false,
    this.titleWidget,
  });
  final String? title;
  final TextStyle? titleStyle;
  final bool automaticallyImplyLeading;
  final bool? centerTitle;
  final Color? backgroundColor;
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;
  final bool isTitleWidget;
  final Widget? titleWidget;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isTitleWidget
          ? titleWidget
          : Text(title?.tr() ?? "", style: titleStyle),
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor,
      leading: leading,
      leadingWidth: leadingWidth,
      actions: actions,
      titleSpacing: 0,
    );
  }
  
}
