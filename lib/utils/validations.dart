import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';

abstract class Validations {
  static String? userNameValidation({required String? name}) {
    if ((name?.isEmpty ?? true) || name?.trim() == "") {
      return AppText.userNameValidation.tr();
    }
    return null;
  }

  static String? validateEmptyText(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.emptyTextValidation.tr();
    }
    return null;
  }

  static String? phoneValidation({required String? phoneNumber}) {
    if (phoneNumber?.trim() == "" ||
        (phoneNumber?.isEmpty ?? true) ||
        phoneNumber == null) {
      return AppText.phoneNumberValidation.tr();
    } else if (phoneNumber.length < 11) {
      return AppText.phoneNumberValidation2.tr();
    }
    return null;
  }

  static String? emailValidation({required String? email}) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9](?:[a-zA-Z0-9._%+-]{0,62}[a-zA-Z0-9])?@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?(?:\.[a-zA-Z]{2,})+$',
    );
    if (email?.trim() == "" || (email?.isEmpty ?? true) || email == null) {
      return AppText.emailValidation.tr();
    } else if (!emailRegex.hasMatch(email) ||
        email.contains("..") ||
        email.contains(".-") ||
        email.contains("-.")) {
      return AppText.emailValidation2.tr();
    }
    return null;
  }

  static String? passwordValidation({required String? password}) {
    if ((password?.isEmpty ?? true) ||
        password?.trim() == "" ||
        password == null) {
      return AppText.passwordValidation.tr();
    } else if (password.length < 8) {
      return AppText.passwordValidation2.tr();
    } else if (RegExp(r'\s').hasMatch(password)) {
      return AppText.passwordValidation3.tr();
    } else if (!RegExp(r'\d').hasMatch(password)) {
      return AppText.passwordValidation4.tr();
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return AppText.passwordValidation6.tr();
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return AppText.passwordValidation7.tr();
    } else if (password.length > 20) {
      return AppText.passwordValidation5.tr();
    }
    return null;
  }

  static String? confirmPasswordValidation({
    required String? conformPassword,
    required String? password,
  }) {
    if ((conformPassword?.isEmpty ?? true) ||
        conformPassword?.trim() == "" ||
        conformPassword == null) {
      return AppText.confirmPasswordValidation.tr();
    } else if (conformPassword != password) {
      return AppText.confirmPasswordValidation2.tr();
    } else if (RegExp(r'\s').hasMatch(conformPassword)) {
      return AppText.passwordValidation3.tr();
    }
    return null;
  }

  static String? otpValidation({required String? code}) {
    if ((code?.isEmpty ?? true) || code?.trim() == "" || code == null) {
      return AppText.otpValidation.tr();
    } else if (code.length < 6) {
      return AppText.otpValidation2.tr();
    }
    return null;
  }
}
