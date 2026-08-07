import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart' show ApiResult;
import 'package:job_task/data/model/request/auth_request/forgot_password_request.dart';
import 'package:job_task/data/model/response/auth_entity/forgot_password_entity.dart';

import 'package:job_task/domain/repository/auth_repo.dart';

@singleton
class ForgotPasswordUseCase {
  final AuthRepo authRepo;
  ForgotPasswordUseCase(this.authRepo);
  Future<ApiResult<ForgotPasswordEntity>>execute(SendEmailRequest forgotPasswordRequest)=>authRepo.forgotPassword(forgotPasswordRequest);


}