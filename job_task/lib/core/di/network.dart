
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:job_task/core/constants/api_constants.dart';

class Network extends QueuedInterceptor {

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {

    options.headers[HttpHeaders.acceptHeader] = ApiConstants.acceptHeader;
    options.headers[HttpHeaders.contentTypeHeader] = ApiConstants.contentType;

    handler.next(options);
  }
  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {

      // Clone options to avoid mutating the original request
      final opts = err.requestOptions.copyWith(
        headers: {
          ...err.requestOptions.headers,
          HttpHeaders.acceptHeader: ApiConstants.acceptHeader,
          HttpHeaders.contentTypeHeader: ApiConstants.contentType,
        },
      );

      // Use a fresh Dio to avoid re-triggering this interceptor
      final retryDio = Dio(BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
      ));

      final response = await retryDio.fetch(opts);
      handler.resolve(response);

    }
  }

