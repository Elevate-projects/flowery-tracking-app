import 'package:flowery_tracking_app/presentation/edit_profile/widgets/gender.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/gender_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class GenderViwe extends StatelessWidget {
   GenderViwe({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GenderCubit(),
      child: const GenderSection(),
    );
  }
}
