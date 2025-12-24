import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_animations.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_cubit.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/location_indicator.dart';
import 'package:flowery_tracking_app/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class MapSection extends StatelessWidget {
  const MapSection({super.key, required this.orderData});

  final OrderEntity orderData;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserAddressMapCubit>();

    return BlocBuilder<UserAddressMapCubit, UserAddressMapState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final driver = state.driverLocation;
        final user = state.userLocation;

        return state.mapStatus.isLoading
            ? const AnimationLoaderWidget(
                text: "",
                animation: AppAnimations.loadingAnimationBlue,
              )
            : FlutterMap(
                mapController: cubit.mapController,
                options: MapOptions(
                  initialCenter: driver ?? user ?? const LatLng(0, 0),
                  initialZoom: 13.sp,
                ),
                children: [
                  TileLayer(urlTemplate: ConstKeys.mapUrlTemplate),
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
                      if (user != null)
                        Marker(
                          point: user,
                          width: 150.w,
                          height: 90.h,
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: LocationIndicator(
                              title: AppText.user.tr(),
                              isNetworkImage: false,
                              imagePath: AppIcons.userLocation,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              );
      },
    );
  }
}
