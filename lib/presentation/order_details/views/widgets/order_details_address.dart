import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/core/constants/app_images.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_intent.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderDetailsAddress extends StatelessWidget {
  const OrderDetailsAddress({
    super.key,
    required this.title,
    required this.image,
    required this.address,
    required this.phone,
    this.onAddressTaped,
  });
  final String title;
  final String image;
  final String address;
  final String phone;
  final void Function()? onAddressTaped;
  @override
  Widget build(BuildContext context) {
    final orderDetailsCubit = BlocProvider.of<OrderDetailsCubit>(context);
    final theme = Theme.of(context);
    return InkWell(
      onTap: onAddressTaped,
      borderRadius: BorderRadius.circular(10.r),
      splashColor: theme.colorScheme.onPrimary,
      highlightColor: theme.colorScheme.onPrimary,
      child: Container(
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
            const RSizedBox(width: 16),
            Padding(
              padding: REdgeInsetsDirectional.only(end: 4),
              child: Row(
                children: [
                  BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
                    builder: (context, state) =>
                        (state.openPhoneStatus.isLoading &&
                            state.isOpeningPhone &&
                            state.selectedPhoneNumber == phone)
                        ? LoadingCircle(
                            circleColor: theme.colorScheme.primary,
                            height: 14.r,
                            width: 14.r,
                          )
                        : InkWell(
                            borderRadius: BorderRadius.circular(100.r),
                            onTap: () async {
                              await orderDetailsCubit.doIntent(
                                intent: OpenPhoneIntent(phoneNumber: phone),
                              );
                            },
                            highlightColor: theme.colorScheme.onPrimary,
                            splashColor: theme.colorScheme.onPrimary,
                            child: RPadding(
                              padding: const EdgeInsets.all(4),
                              child: SvgPicture.asset(
                                AppIcons.phone,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                  ),
                  const RSizedBox(width: 8),
                  BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
                    builder: (context, state) =>
                        (state.openWhatsappStatus.isLoading &&
                            state.isOpeningWhatsapp &&
                            state.selectedPhoneNumber == phone)
                        ? LoadingCircle(
                            circleColor: theme.colorScheme.primary,
                            height: 14.r,
                            width: 14.r,
                          )
                        : InkWell(
                            borderRadius: BorderRadius.circular(100.r),
                            highlightColor: theme.colorScheme.onPrimary,
                            splashColor: theme.colorScheme.onPrimary,
                            onTap: () async {
                              await orderDetailsCubit.doIntent(
                                intent: OpenWhatsAppIntent(phoneNumber: phone),
                              );
                            },
                            child: RPadding(
                              padding: const EdgeInsets.all(4),
                              child: SvgPicture.asset(
                                AppIcons.whatsapp,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
