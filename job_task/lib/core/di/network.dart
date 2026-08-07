import 'dart:io';

import 'package:dio/dio.dart';
import 'package:job_task/core/constants/shard_prefes_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:job_task/core/constants/api_constants.dart';

class Network extends QueuedInterceptor {
  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString(SharedPrefs.token);

    options.headers[HttpHeaders.acceptHeader] =
        ApiConstants.acceptHeader;

    options.headers[HttpHeaders.contentTypeHeader] =
        ApiConstants.contentType;

    if (token != null && token.isNotEmpty) {
      options.headers[HttpHeaders.authorizationHeader] =
      '${ApiConstants.bearerPrefix} $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    handler.next(err);
  }
}