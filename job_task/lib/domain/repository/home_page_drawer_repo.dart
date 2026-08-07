import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/auth_request/update_profile_request.dart';
import 'package:job_task/data/model/response/about_us_entity.dart';
import 'package:job_task/data/model/response/auth_entity/update_profile_entity.dart';
import 'package:job_task/data/model/response/branch_entity.dart';


abstract class HomePageDrawerRepo {
 Future<ApiResult<AboutUsEntity>>aboutUs();
 Future<ApiResult<BranchEntity>>getBranches();
 Future<ApiResult<UpdateProfileEntity>>updateProfile({required UpdateProfileRequest updateProfileRequest});
}

