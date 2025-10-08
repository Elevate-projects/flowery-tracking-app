import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view/edit_profile_view_body.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileCubit>(
      create: (_) => getIt.get<EditProfileCubit>(),
      child: const EditProfileViewBody(),
    );
  }
}

