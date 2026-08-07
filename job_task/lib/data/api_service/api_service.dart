import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:job_task/core/constants/api_constants.dart';
import 'package:job_task/data/model/request/auth_request/forgot_password_request.dart';
import 'package:job_task/data/model/request/auth_request/login_request.dart';
import 'package:job_task/data/model/request/auth_request/register_request.dart';
import 'package:job_task/data/model/request/auth_request/update_profile_request.dart';
import 'package:job_task/data/model/response/about_us_entity.dart';
import 'package:job_task/data/model/response/auth_entity/check_email_verified_entity.dart';
import 'package:job_task/data/model/response/auth_entity/forgot_password_entity.dart';
import 'package:job_task/data/model/response/auth_entity/login_entity.dart';
import 'package:job_task/data/model/response/auth_entity/register_entity.dart';
import 'package:job_task/data/model/response/auth_entity/update_profile_entity.dart';
import 'package:job_task/data/model/response/auth_entity/verify_email_entity.dart';
import 'package:job_task/data/model/response/branch_entity.dart';
import 'package:job_task/data/model/response/product_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio) = _ApiService;

  @GET(ApiConstants.products)
  Future<List<ProductEntity>> getProducts();

  @POST("auth/login")
  Future<LoginEntity> login(@Body()LoginRequest login);
  @POST("auth/forgot-password")
  Future<ForgotPasswordEntity> forgotPassword(@Body()SendEmailRequest forgotPassword);

  @POST("auth/register")
  Future<RegisterEntity> register(@Body()RegisterRequest register);

  @POST('auth/resend-verify-email')
  Future<VerifyEmailEntity> verifyEmail(@Body()SendEmailRequest verifyEmail);

  @POST('auth/check-verify-email')
  Future<CheckEmailVerifiedEntity> checkIfVerifyEmail(@Body()SendEmailRequest verifyEmail);
  @GET('company-info')
  Future<AboutUsEntity> getAboutUS();
  @GET('company-branch')
  Future<BranchEntity> companyBranch();

  @POST('user/profile')
  Future<UpdateProfileEntity> updateProfile(@Body() UpdateProfileRequest  profileRequest);



}