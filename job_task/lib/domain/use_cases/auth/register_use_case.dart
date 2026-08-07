import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/auth_request/register_request.dart';
import 'package:job_task/data/model/response/auth_entity/register_entity.dart';
import 'package:job_task/domain/repository/auth_repo.dart';

@singleton
class RegisterUseCase {
  final AuthRepo authRepo;
  RegisterUseCase(this.authRepo);
  Future<ApiResult<RegisterEntity>>execute(RegisterRequest register)=>authRepo.register(register);


}