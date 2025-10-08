import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapMarkers {
  static Marker buildMarker({
    required LatLng point,
    required Color color,
    required String icon,
    required String label,
  }) {
    return Marker(
      point: point,
      width: 130.w,
      height: 60.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          RPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: color,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(icon, height: 20.h, width: 20.w),
                  const RSizedBox(width: 2),
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 2,
            bottom: 3,
            left: 45.w,
            child: Transform.rotate(
              angle: 3.14,
              child: const Icon(
                Icons.arrow_drop_up,
                color: AppColors.pink,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
