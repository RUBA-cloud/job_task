import 'package:dio/dio.dart';

class DioExceptionExtension {
  static String parseDioError(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? 'Server Error';
    }

    return switch (e.type) {
      DioExceptionType.connectionError => 'No Internet Connection',
      DioExceptionType.connectionTimeout => 'Connection Timeout',
      DioExceptionType.receiveTimeout => 'Receive Timeout',
      DioExceptionType.sendTimeout => 'Send Timeout',
      DioExceptionType.badResponse => 'Server Error',
      DioExceptionType.badCertificate => 'Bad Certificate',
      DioExceptionType.cancel => 'Request Cancelled',
      DioExceptionType.unknown => e.message ?? 'Unknown Error',
      _ => e.message ?? 'Unknown Error',
    };
  }
}