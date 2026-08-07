// lib/core/network/api_result.dart

import 'package:dio/dio.dart';

sealed class ApiResult<T> {
  const ApiResult();
}

class Success<T> extends ApiResult<T> {
  final T data;
  final int? statusCode;

  const Success({
    required this.data,
    this.statusCode,
  });
}

class Failure<T> extends ApiResult<T> {
  final DioException? error;
  final int? statusCode;
  final  String? sqlError;

  Failure({
  this.error,
    this.statusCode,
    this.sqlError,
  });

  /// Backend status e.g. validation_error
  String? get status {
    final data = error?.response?.data;

    if (data is Map<String, dynamic>) {
      return data['status']?.toString();
    }

    return null;
  }

  /// Validation errors
  Map<String, dynamic> get errors {
    final data = error?.response?.data;

    if (data is Map<String, dynamic>) {
      final errors = data['errors'];

      if (errors is Map<String, dynamic>) {
        return errors;
      }
    }

    return {};
  }

  /// Get error for specific field
  String? fieldError(String field) {
    final value = errors[field];

    if (value is List && value.isNotEmpty) {
      return value.first.toString();
    }

    return null;
  }

  /// Backend message or Dio error message
  String get message {
    final data = error?.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'];

      if (message != null) {
        return message.toString();
      }
    }

    return error?.message ?? 'Something went wrong';
  }

  bool get isValidationError =>
      error?.response?.statusCode == 422;

  bool hasFieldError(String field) =>
      errors.containsKey(field);
}