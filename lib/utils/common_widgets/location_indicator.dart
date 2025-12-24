import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LocationIndicator extends StatelessWidget {
  const LocationIndicator({
    super.key,
    this.isNetworkImage = false,
    required this.imagePath,
    required this.title,
  });
  final bool isNetworkImage;
  final String imagePath;
  final String title;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: REdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48.r),
            color: theme.colorScheme.primary,
          ),
          child: Row(
            children: [
              Container(
                width: 16.r,
                height: 16.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.secondary,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: RSizedBox(
                    height: 10,
                    width: 10,
                    child: isNetworkImage
                        ? CachedNetworkImage(
                            imageUrl: imagePath,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error_outline),
                            placeholder: (context, url) => ShimmerEffect(
                              width: 10.r,
                              height: 10.r,
                              radius: 42.r,
                            ),
                            fit: BoxFit.cover,
                          )
                        : SvgPicture.asset(imagePath, fit: BoxFit.cover),
                  ),
                ),
              ),
              const RSizedBox(width: 4),
              Text(title, style: theme.textTheme.labelSmall),
            ],
          ),
        ),
        SvgPicture.asset(AppIcons.reversedTriangle),
      ],
    );
  }
}
