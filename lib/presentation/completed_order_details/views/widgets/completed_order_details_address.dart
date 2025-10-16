import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompletedOrderDetailsAddress extends StatelessWidget {
  const CompletedOrderDetailsAddress({
    super.key,
    required this.title,
    required this.image,
    required this.address,
    required this.phone,
  });
  final String title;
  final String image;
  final String address;
  final String phone;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.25),
            blurStyle: BlurStyle.outer,
            blurRadius: 4.r,
          ),
        ],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundImage: CachedNetworkImageProvider(image),
            onBackgroundImageError: (exception, stackTrace) => Icons.info,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: image,
                errorWidget: (context, url, error) =>
                    CachedNetworkImage(imageUrl: AppImages.dummyProfile),
              ),
            ),
          ),
          const RSizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.shadow,
                  ),
                ),
                const RSizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.location, fit: BoxFit.contain),
                    const RSizedBox(width: 4),
                    Flexible(
                      child: Text(
                        address,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: "Roboto",
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
