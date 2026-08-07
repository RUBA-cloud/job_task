import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/api_service/api_service.dart';
import 'package:job_task/data/model/request/auth_request/forgot_password_request.dart';
import 'package:job_task/data/model/request/auth_request/login_request.dart';
import 'package:job_task/data/model/request/auth_request/register_request.dart';
import 'package:job_task/data/model/request/auth_request/update_profile_request.dart';
import 'package:job_task/data/model/response/auth_entity/check_email_verified_entity.dart';
import 'package:job_task/data/model/response/auth_entity/forgot_password_entity.dart';
import 'package:job_task/data/model/response/auth_entity/login_entity.dart';
import 'package:job_task/data/model/response/auth_entity/register_entity.dart';
import 'package:job_task/data/model/response/auth_entity/update_profile_entity.dart';
import 'package:job_task/data/model/response/auth_entity/verify_email_entity.dart';
import 'package:job_task/domain/repository/auth_repo.dart';


@Injectable(as: AuthRepo)
class AuthRepoImp implements AuthRepo {
  final ApiService apiService;

  AuthRepoImp(this.apiService);


  @override
  Future<ApiResult<LoginEntity>> login(LoginRequest request) async {
    try {
      final result = await apiService.login(request);

      return Success(
        data: result,
      );

    } on DioException catch (e) {
      return Failure(
        error: e,
        statusCode: e.response?.statusCode,
      );
    }
  }


  @override
  Future<ApiResult<ForgotPasswordEntity>> forgotPassword(
      SendEmailRequest forgotPassword) async {
    try {
      final result = await apiService.forgotPassword(forgotPassword);

      return Success(
        data: result,
      );

    } on DioException catch (e) {
      return Failure(
        error: e,
        statusCode: e.response?.statusCode,
      );
    }
  }


  @override
  Future<ApiResult<RegisterEntity>> register(RegisterRequest registerRequest) async {

    try {
      final result = await apiService.register(registerRequest);

      return Success(
        data: result,
      );

    } on DioException catch (e) {
      return Failure(
        error: e,
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<CheckEmailVerifiedEntity>> checkIfEmailIsVerified(SendEmailRequest forgotPassword)async {
    try {
      final result = await apiService.checkIfVerifyEmail(forgotPassword);

      return Success(
        data: result,
      );

    } on DioException catch (e) {
      return Failure(
        error: e,
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<VerifyEmailEntity>> verifyEmail(SendEmailRequest forgotPassword)async {
    try {
      final result = await apiService.verifyEmail(forgotPassword);

      return Success(
        data: result,
      );

    } on DioException catch (e) {
      return Failure(
        error: e,
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<UpdateProfileEntity>> updateProfile(UpdateProfileRequest profileRequest)async {
    try {
      final result = await apiService.updateProfile(profileRequest);

      return Success(
        data: result,
      );

    } on DioException catch (e) {
      return Failure(
        error: e,
        statusCode: e.response?.statusCode,
      );
    }
  }
}