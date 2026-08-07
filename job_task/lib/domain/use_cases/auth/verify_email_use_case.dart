import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/auth_request/forgot_password_request.dart';
import 'package:job_task/data/model/response/auth_entity/verify_email_entity.dart';
import 'package:job_task/domain/repository/auth_repo.dart';

@singleton
class VerifyEmailUseCase {
  final AuthRepo authRepo;
  VerifyEmailUseCase(this.authRepo);
  Future<ApiResult<VerifyEmailEntity>>execute(SendEmailRequest request)=>authRepo.verifyEmail(request);


}