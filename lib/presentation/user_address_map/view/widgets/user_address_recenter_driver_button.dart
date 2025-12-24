import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_cubit.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAddressRecenterDriverButton extends StatelessWidget {
  const UserAddressRecenterDriverButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pickUpMapCubit = BlocProvider.of<UserAddressMapCubit>(context);
    return RPadding(
      padding: const EdgeInsets.only(top: 8),
      child: FloatingActionButton(
        backgroundColor: theme.colorScheme.secondary,
        onPressed: () {
          pickUpMapCubit.doIntent(const RecenterCameraOnDriverIntent());
        },
        child: Icon(Icons.my_location, color: theme.colorScheme.primary),
      ),
    );
  }
}
