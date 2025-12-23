import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view/widgets/edit_profile_view_body.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_intent.dart';
import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.profileCubit});
  final ProfileCubit profileCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileCubit>(
      create: (context) =>
          getIt.get<EditProfileCubit>()
            ..doIntent(intent: InitializeEditProfile()),
<<<<<<< HEAD
      child: EditProfileViewBody(profileCubit:profileCubit,),
=======
      child: const EditProfileViewBody(),
>>>>>>> 6c822904059ec14f2229a729dbe759badebe7731
    );
  }
}
