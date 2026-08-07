
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/auth_request/update_profile_request.dart';
import 'package:job_task/data/model/response/auth_entity/update_profile_entity.dart';
import 'package:job_task/domain/repository/auth_repo.dart';

@singleton
class UpdateProfileUseCase {
  final AuthRepo authRepo;
  UpdateProfileUseCase(this.authRepo);
  Future<ApiResult<UpdateProfileEntity>>execute(UpdateProfileRequest request)=>authRepo.updateProfile(request);


}