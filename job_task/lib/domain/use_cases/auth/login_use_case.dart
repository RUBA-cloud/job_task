import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart' show ApiResult;
import 'package:job_task/data/model/request/auth_request/login_request.dart';
import 'package:job_task/data/model/response/auth_entity/login_entity.dart';
import 'package:job_task/domain/repository/auth_repo.dart';

@singleton
class LoginUseCase {
  final AuthRepo authRepo;
  LoginUseCase(this.authRepo);
  Future<ApiResult<LoginEntity>>execute(LoginRequest login)=>authRepo.login(login);


}