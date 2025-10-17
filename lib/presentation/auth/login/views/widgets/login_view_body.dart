import 'package:flowery_tracking_app/core/constants/app_animations.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views/widgets/login_button.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views/widgets/login_form.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views/widgets/remember_me_and_forget_pass_row.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flowery_tracking_app/utils/loaders/full_screen_loader.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current.loginStatus.isFailure ||
          current.loginStatus.isSuccess ||
          current.loginStatus.isLoading,
      listener: (context, state) {
        if (state.loginStatus.isLoading) {
          FullScreenLoader.openLoadingDialog(
            text: AppText.loggingInMessage,
            animation: AppAnimations.loadingMobile,
            context: context,
          );
        } else if (state.loginStatus.isFailure) {
          FullScreenLoader.stopLoading(context: context);
          Loaders.showErrorMessage(
            message: state.loginStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.loginStatus.isSuccess) {
          FullScreenLoader.stopLoading(context: context);
          if (FloweryDriverMethodHelper.currentDriverOrderId != null) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteNames.orderDetails,
              (route) => false,
            );
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteNames.bottomNavigation,
              (route) => false,
            );
          }
        }
      },
      child: SingleChildScrollView(
        child: RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (previous, current) =>
                current.loginStatus.isLoading || current.loginStatus.isFailure,
            builder: (context, state) => AbsorbPointer(
              absorbing: state.loginStatus.isLoading,
              child: const Column(
                children: [
                  RSizedBox(height: 12),
                  LoginForm(),
                  RSizedBox(height: 15),
                  RememberMeAndForgetPassRow(),
                  RSizedBox(height: 47),
                  LoginButton(),
                  RSizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
