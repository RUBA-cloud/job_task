import 'package:job_task/core/di/api_result.dart';
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

abstract class AuthRepo {
  Future<ApiResult<LoginEntity>>login(LoginRequest login);
  Future<ApiResult<ForgotPasswordEntity>>forgotPassword(SendEmailRequest forgotPassword);
  Future<ApiResult<RegisterEntity>>register(RegisterRequest registerRequest);
  Future<ApiResult<CheckEmailVerifiedEntity>>checkIfEmailIsVerified(SendEmailRequest forgotPassword);
  Future<ApiResult<VerifyEmailEntity>>verifyEmail(SendEmailRequest forgotPassword);
  Future<ApiResult<UpdateProfileEntity>>updateProfile(UpdateProfileRequest profileRequest);


}