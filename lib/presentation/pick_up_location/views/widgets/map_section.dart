import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views/widgets/map_markers.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views_model/pick_up_address_cubit.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views_model/pick_up_address_state.dart';
import 'package:flowery_tracking_app/utils/dialogs/custom_dialog_content.dart';
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
        final store = state.storeLocation;

        if (state.error != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => CustomDialogContent(
                content: Text(
                  state.error!,
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(AppText.ok),
                  ),
                ],
              ),
            );
          });
        }

        return Stack(
          children: [
            FlutterMap(
              mapController: cubit.mapController,

              options: MapOptions(
                initialCenter: driver ?? store ?? const LatLng(30.0444, 31.2357),
                initialZoom: 15.0,
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
                        icon:  AppIcons.location2,
                        label: AppText.yourLocation,
                      ),
                    if (store != null)
                      MapMarkers.buildMarker(
                        point: store,
                        color: Colors.pink,
                        icon: AppIcons.flower,
                        label: AppText.flowery,
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
