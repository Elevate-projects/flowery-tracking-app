import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_cubit.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
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

        return Stack(
          children: [
            SizedBox.expand(
              child: FlutterMap(
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
                          child: Image.asset(AppIcons.userLocation),
                        ),
                      if (driver != null)
                        Marker(
                          point: driver,
                          width: 150.w,
                          height: 90.h,
                          alignment: Alignment.center,
                          child: Image.asset(AppIcons.driveLocation),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10.r,
              left: 10.r,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
