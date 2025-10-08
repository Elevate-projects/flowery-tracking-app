import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_images.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsItem extends StatelessWidget {
  const OrderDetailsItem({super.key, required this.orderData});
  final OrderItemEntity orderData;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundImage: CachedNetworkImageProvider(
              orderData.product?.imgCover ?? "",
            ),
            onBackgroundImageError: (exception, stackTrace) => Icons.info,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: orderData.product?.imgCover ?? "",
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
                  orderData.product?.title ?? AppText.notProvided.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.shadow,
                  ),
                ),
                const RSizedBox(height: 8),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "${AppText.egp.tr()} ${orderData.product?.price}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
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
          Padding(
            padding: REdgeInsetsDirectional.only(end: 8),
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: Text(
                "X${orderData.quantity.toString()}",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
