import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views/widgets/map_markers.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views_model/pick_up_address_cubit.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views_model/pick_up_address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class MapSection extends StatelessWidget {
  final OrderEntity orderData;

  const MapSection({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PickUpAddressCubit>();

    return BlocBuilder<PickUpAddressCubit, PickupAddressState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final driver = state.driverLocation;
        final user = state.userLocation;

        return Stack(
          children: [
            FlutterMap(
              mapController: cubit.mapController,

              options: MapOptions(
                initialCenter: driver ?? user ?? const LatLng(0, 0),
                initialZoom: 15.sp,
              ),

              children: [
                TileLayer(
                  urlTemplate:
                  'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                if (state.routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: state.routePoints,
                        strokeWidth: 5.w,
                        color: theme.primaryColor,
                      ),
                    ],
                  ),

                MarkerLayer(
                  markers: [
                    if (driver != null)
                      MapMarkers.buildMarker(
                        point: driver,
                        color: Colors.pink,
                        icon: AppIcons.flower,
                        label: AppText.flower,
                      ),
                    if (user != null)
                      MapMarkers.buildMarker(
                        point: user,
                        color: Colors.pink,
                        icon: AppIcons.flower,
                        label: AppText.userLocation,
                      ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
