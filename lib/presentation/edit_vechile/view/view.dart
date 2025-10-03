import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view/edit_vehicle_view_body.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view_model/edit_vehicle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class EditVehicleView extends StatelessWidget {
  const EditVehicleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditVehicleCubit>(
      create: (_) => getIt.get<EditVehicleCubit>(),
      child: const EditVehicleViewBody(),
    );
  }
}
