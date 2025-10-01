import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';

class FirebaseExceptions extends Failure {
  FirebaseExceptions({required super.responseException});

  factory FirebaseExceptions.firebaseExceptions(FirebaseException e) {
    switch (e.code) {
      case 'unknown':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.unknownFirebaseError.tr(),
          ),
        );
      case 'invalid-custom-token':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.invalidCustomToken.tr(),
          ),
        );
      case 'custom-token-mismatch':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.customTokenMismatch.tr(),
          ),
        );
      case 'user-disabled':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.userDisabled.tr(),
          ),
        );
      case 'user-not-found':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.userNotFound.tr(),
          ),
        );
      case 'invalid-email':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.invalidEmail.tr(),
          ),
        );
      case 'email-already-in-use':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.emailAlreadyInUse.tr(),
          ),
        );
      case 'wrong-password':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.wrongPassword.tr(),
          ),
        );
      case 'weak-password':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.weakPassword.tr(),
          ),
        );
      case 'provider-already-linked':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.providerAlreadyLinked.tr(),
          ),
        );
      case 'operation-not-allowed':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.operationNotAllowed.tr(),
          ),
        );
      case 'invalid-credential':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.invalidCredential.tr(),
          ),
        );
      case 'invalid-verification-code':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.invalidVerificationCode.tr(),
          ),
        );
      case 'invalid-verification-id':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.invalidVerificationId.tr(),
          ),
        );
      case 'captcha-check-failed':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.captchaCheckFailed.tr(),
          ),
        );
      case 'app-not-authorized':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.appNotAuthorized.tr(),
          ),
        );
      case 'keychain-error':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.keychainError.tr(),
          ),
        );
      case 'internal-error':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.internalError.tr(),
          ),
        );
      case 'invalid-app-credential':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.invalidAppCredential.tr(),
          ),
        );
      case 'user-mismatch':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.userMismatch.tr(),
          ),
        );
      case 'requires-recent-login':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.requiresRecentLogin.tr(),
          ),
        );
      case 'quota-exceeded':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.quotaExceeded.tr(),
          ),
        );
      case 'account-exists-with-different-credential':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.accountExistsWithDifferentCredential.tr(),
          ),
        );
      case 'missing-iframe-start':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.missingIframeStart.tr(),
          ),
        );
      case 'missing-iframe-end':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.missingIframeEnd.tr(),
          ),
        );
      case 'missing-iframe-src':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.missingIframeSrc.tr(),
          ),
        );
      case 'auth-domain-config-required':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.authDomainConfigRequired.tr(),
          ),
        );
      case 'missing-app-credential':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.missingAppCredential.tr(),
          ),
        );
      case 'session-cookie-expired':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.sessionCookieExpired.tr(),
          ),
        );
      case 'uid-already-exists':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.uidAlreadyExists.tr(),
          ),
        );
      case 'web-storage-unsupported':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.webStorageUnsupported.tr(),
          ),
        );
      case 'app-deleted':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.appDeleted.tr(),
          ),
        );
      case 'user-token-mismatch':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.userTokenMismatch.tr(),
          ),
        );
      case 'invalid-message-payload':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.invalidMessagePayload.tr(),
          ),
        );
      case 'invalid-sender':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.invalidSender.tr(),
          ),
        );
      case 'invalid-recipient-email':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.invalidRecipientEmail.tr(),
          ),
        );
      case 'missing-action-code':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.missingActionCode.tr(),
          ),
        );
      case 'user-token-expired':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.userTokenExpired.tr(),
          ),
        );
      case 'INVALID_LOGIN_CREDENTIALS':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.invalidLoginCredentials.tr(),
          ),
        );
      case 'expired-action-code':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.expiredActionCode.tr(),
          ),
        );
      case 'invalid-action-code':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.invalidActionCode.tr(),
          ),
        );
      case 'credential-already-in-use':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.credentialAlreadyInUse.tr(),
          ),
        );
      case 'permission-denied':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.permissionDenied.tr(),
          ),
        );
      case 'unavailable':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.unavailable.tr(),
          ),
        );
      case 'not-found':
        return FirebaseExceptions(
          responseException: ResponseException(message: AppText.notFound.tr()),
        );
      case 'already-exists':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.alreadyExists.tr(),
          ),
        );
      case 'resource-exhausted':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.resourceExhausted.tr(),
          ),
        );
      case 'cancelled':
        return FirebaseExceptions(
          responseException: ResponseException(message: AppText.cancelled.tr()),
        );
      case 'deadline-exceeded':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.deadlineExceeded.tr(),
          ),
        );
      case 'data-loss':
        return FirebaseExceptions(
          responseException: ResponseException(message: AppText.dataLoss.tr()),
        );
      case 'invalid-argument':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.invalidArgument.tr(),
          ),
        );
      case 'internal':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.internalError.tr(),
          ),
        );
      case 'aborted':
        return FirebaseExceptions(
          responseException: ResponseException(message: AppText.aborted.tr()),
        );
      case 'out-of-range':
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.outOfRange.tr(),
          ),
        );
      default:
        return FirebaseExceptions(
          responseException: ResponseException(
            message: AppText.unknownAuthError.tr(),
          ),
        );
    }
  }
}
