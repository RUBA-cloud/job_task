import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/api_service/api_service.dart';
import 'package:job_task/data/model/request/auth_request/update_profile_request.dart';
import 'package:job_task/data/model/response/about_us_entity.dart';
import 'package:job_task/data/model/response/auth_entity/update_profile_entity.dart';
import 'package:job_task/data/model/response/branch_entity.dart';
import 'package:job_task/domain/repository/home_page_drawer_repo.dart';

@Injectable(as: HomePageDrawerRepo)
class HomePageDrawerRepoImp implements HomePageDrawerRepo {
  final ApiService _apiService;

  const HomePageDrawerRepoImp(this._apiService);

  @override
  Future<ApiResult<AboutUsEntity>> aboutUs() async {
    try {
      final response = await _apiService.getAboutUS();

      return Success(
        data: response,
      );
    } on DioException catch (e) {
      return Failure(
        error: e,
        statusCode: e.response?.statusCode,
      );

    }

  }

  @override
  Future<ApiResult<BranchEntity>> getBranches()async {
    try {
      final response = await _apiService.companyBranch();

      return Success(
        data: response,
      );
    } on DioException catch (e) {
      return Failure(
        error: e,
        statusCode: e.response?.statusCode,
      );

    }
  }

  @override
  Future<ApiResult<UpdateProfileEntity>> updateProfile({required UpdateProfileRequest updateProfileRequest}) async{
    try {
      final response = await _apiService.updateProfile(updateProfileRequest);

      return Success(
        data: response,
      );
    } on DioException catch (e) {
      return Failure(
        error: e,
        statusCode: e.response?.statusCode,
      );

    }
  }}