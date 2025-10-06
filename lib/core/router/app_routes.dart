import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flowery_tracking_app/presentation/auth/forget_password/views/forget_password.dart';
import 'package:flowery_tracking_app/presentation/auth/login/views/login_view.dart';
import 'package:flowery_tracking_app/presentation/auth/reset_password/views/reset_password.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views/email_verification.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:flowery_tracking_app/presentation/onboarding/views/onboarding_view.dart';
import 'package:flowery_tracking_app/presentation/order_details/views/order_details_view.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views/profile_reset_password.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginView());

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

      default:
        return null;
    }
  }
}
