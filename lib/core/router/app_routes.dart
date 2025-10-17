import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/auth/application_approved/views/application_approved_view.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/views/apply_view.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views/forget_password.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views/login_view.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views/reset_password.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views/email_verification.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:flowery_tracking_app/presentation/completed_order_details/views/completed_order_details_view.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/view/edit_profile_view.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view/view.dart';
import 'package:flowery_tracking_app/presentation/onboarding/views/onboarding_view.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views/pick_up_address_view.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/order_details_view.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/success_screen.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_addresses.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views/profile_reset_password.dart';
import 'package:flowery_tracking_app/presentation/profile/views/profile_views.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view/user_address_map_view.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case RouteNames.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileView());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouteNames.editVehicle:
        return MaterialPageRoute(builder: (_) => const EditVehicleView());

      case RouteNames.bottomNavigation:
        return MaterialPageRoute(builder: (_) => const BottomNavigationView());

      case RouteNames.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());

      case RouteNames.emailVerification:
        return MaterialPageRoute(
          builder: (_) =>
              EmailVerificationView(email: settings.arguments as String),
        );

      case RouteNames.resetPassword:
        return MaterialPageRoute(
          builder: (_) => ResetPassword(email: settings.arguments as String),
        );
      case RouteNames.profileResetPassword:
        return MaterialPageRoute(builder: (_) => const ProfileResetPassword());

      case RouteNames.orderDetails:
        return MaterialPageRoute(builder: (_) => const OrderDetailsView());

      case RouteNames.pickUpAddress:
        return MaterialPageRoute(builder: (_) => PickUpAddressView(
          orderData: settings.arguments as OrderEntity,));

      case RouteNames.completedOrderDetails:
        return MaterialPageRoute(
          builder: (_) => CompletedOrderDetailsView(
            orderData: settings.arguments as OrderEntity,
          ),
        );

      case RouteNames.userAddressMap:
        return MaterialPageRoute(
          builder: (_) => UserAddressMapView(
            userAddressMapArguments:
                settings.arguments as UserAddressMapArguments,
          ),
        );
      case RouteNames.successScreen:
        return MaterialPageRoute(builder: (_) => const SuccessScreen());
      case RouteNames.profile:
        return MaterialPageRoute(builder: (_) => const ProfileView());

      case RouteNames.applicationApproved:
        return MaterialPageRoute(
          builder: (_) => const ApplicationApprovedView(),
        );

      case RouteNames.apply:
        return MaterialPageRoute(builder: (_) => const ApplyView());
      default:
        return null;
    }
  }
}
