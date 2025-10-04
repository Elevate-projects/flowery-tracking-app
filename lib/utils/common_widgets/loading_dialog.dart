import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context, {Color color = Colors.white}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(child: CircularProgressIndicator(color: color)),
    ),
  );
}
