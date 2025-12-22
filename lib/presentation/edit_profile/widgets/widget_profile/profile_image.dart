
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_tracking_app/core/constants/app_icons.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_intent.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view_model/edit_profile_status.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;

  const ProfileImage({
    super.key,
    required this.imageUrl,
    this.width = 74,
    this.height = 79,
  });

  @override
  Widget build(BuildContext context) {
    final editProfileCubit = BlocProvider.of<EditProfileCubit>(context);
    final theme = Theme.of(context);
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 40.5.r,
              backgroundColor: theme.colorScheme.onPrimary,
              backgroundImage: state.uploadPhotoState.isInitial
                  ? CachedNetworkImageProvider(
                      FloweryDriverMethodHelper.driverData?.photo ?? "",
                    )
                  : FileImage(state.uploadPhotoState.data ?? File("")),
              child: state.uploadPhotoState.isLoading
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
            PositionedDirectional(
              bottom: 5.r,
              end: -6.r,
              child: GestureDetector(
                  onTap: () async =>
              await editProfileCubit.doIntent(intent: UploadPhotoIntent()),
                child: Container(
                  padding: EdgeInsets.all(5.r),
                  width: 24.r,
                  height: 24.r,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  ),
                  child: Icon( Icons.camera_alt_rounded, size: 14.r),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
