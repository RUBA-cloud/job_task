import 'package:injectable/injectable.dart';

import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/auth_request/forgot_password_request.dart';
import 'package:job_task/data/model/response/auth_entity/check_email_verified_entity.dart';

import 'package:job_task/domain/repository/auth_repo.dart';

@injectable
class CheckEmailVerifiedUseCase {
  final AuthRepo authRepo;

  CheckEmailVerifiedUseCase(this.authRepo);

  Future<ApiResult<CheckEmailVerifiedEntity>> execute(
      SendEmailRequest request,
      ) {
    return authRepo.checkIfEmailIsVerified(request);
  }
}