import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/constants/endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class ApiModule {
  @singleton
  Dio provideDio() {
    final dio = Dio(
      BaseOptions(baseUrl: Endpoints.baseUrl, receiveDataWhenStatusError: true),
    );
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ),
    );
    return dio;
  }
}
