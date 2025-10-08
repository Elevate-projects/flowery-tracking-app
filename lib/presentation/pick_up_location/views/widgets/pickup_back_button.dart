import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickupBackButton extends StatelessWidget {
   const PickupBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme =Theme.of(context);

    return Positioned(
      top: 50.sp,
      left: 15.sp,
      child: InkWell(
           onTap: () => Navigator.pop(context),

        child:   CircleAvatar(
          backgroundColor:
              theme.primaryColor,
           child: Icon(Icons.arrow_back_ios_new,
               color: theme.cardColor,

           ),
        ),
      ),
    );
  }
}
