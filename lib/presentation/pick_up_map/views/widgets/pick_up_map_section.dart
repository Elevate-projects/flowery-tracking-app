import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_animations.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/presentation/pick_up_map/views_model/pick_up_map_cubit.dart';
import 'package:flowery_tracking_app/presentation/pick_up_map/views_model/pick_up_map_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/location_indicator.dart';
import 'package:flowery_tracking_app/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickUpMapSection extends StatelessWidget {
  const PickUpMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pickUpCubit = BlocProvider.of<PickUpMapCubit>(context);
    return BlocBuilder<PickUpMapCubit, PickUpMapState>(
      builder: (context, state) => state.mapStatus.isLoading
          ? const AnimationLoaderWidget(
              text: "",
              animation: AppAnimations.loadingAnimationBlue,
            )
          : FlutterMap(
              mapController: pickUpCubit.mapController,
              options: MapOptions(
                initialCenter: state.driverLocation,
                initialZoom: state.currentZoom,
              ),
              children: [
                TileLayer(
                  urlTemplate: ConstKeys.mapUrlTemplate,
                  userAgentPackageName: ConstKeys.appPackageName,
                ),
                CurrentLocationLayer(
                  style: LocationMarkerStyle(
                    accuracyCircleColor: theme.colorScheme.primary.withValues(
                      alpha: 0.2,
                    ),
                    headingSectorColor: theme.colorScheme.primary.withValues(
                      alpha: 0.5,
                    ),
                    marker: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: LocationIndicator(
                        title: AppText.yourLocation.tr(),
                        isNetworkImage: false,
                        imagePath: AppIcons.mapLocation,
                      ),
                    ),
                    markerAlignment: Alignment.center,
                    markerSize: Size.square(100.r),
                  ),
                ),
                if (state.polylinePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: state.polylinePoints,
                        color: theme.primaryColor,
                        strokeWidth: 5.w,
                      ),
                    ],
                  ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: state.storeLocation,
                      width: 150.w,
                      height: 90.h,
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: LocationIndicator(
                          title:
                              state.orderData?.store?.name ??
                              AppText.notProvided.tr(),
                          isNetworkImage: true,
                          imagePath: state.orderData?.store?.image ?? "",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
