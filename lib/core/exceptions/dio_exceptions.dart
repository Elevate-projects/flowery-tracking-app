import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';

class DioExceptions extends Failure {
  DioExceptions({required super.responseException});

  factory DioExceptions.handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return DioExceptions(
            responseException: ResponseException(
              message: AppText.connectionTimeout.tr(),
            ),
          );
        case DioExceptionType.sendTimeout:
          return DioExceptions(
            responseException: ResponseException(
              message: AppText.sendTimeout.tr(),
            ),
          );
        case DioExceptionType.receiveTimeout:
          return DioExceptions(
            responseException: ResponseException(
              message: AppText.receiveTimeout.tr(),
            ),
          );
        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);
        case DioExceptionType.cancel:
          return DioExceptions(
            responseException: ResponseException(
              message: AppText.requestCancelled.tr(),
            ),
          );
        case DioExceptionType.unknown:
          return DioExceptions(
            responseException: ResponseException(
              message: AppText.networkError.tr(),
            ),
          );
        case DioExceptionType.connectionError:
          return DioExceptions(
            responseException: ResponseException(
              message: AppText.connectionError.tr(),
            ),
          );
        default:
          return DioExceptions(
            responseException: ResponseException(
              message: AppText.unexpectedErrorOccurred.tr(),
            ),
          );
      }
    } else {
      return DioExceptions(
        responseException: ResponseException(message: error.toString()),
      );
    }
  }

  static DioExceptions _handleBadResponse(Response? response) {
    return DioExceptions(
      responseException: ResponseException.handleException(response: response),
    );
  }
}
