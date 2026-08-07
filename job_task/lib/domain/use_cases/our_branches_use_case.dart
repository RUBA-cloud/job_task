import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/response/branch_entity.dart';
import 'package:job_task/domain/repository/home_page_drawer_repo.dart';

@singleton
class OurBranchUseCase {

  final HomePageDrawerRepo authRepo;
  OurBranchUseCase(this.authRepo);
  Future<ApiResult<BranchEntity>>execute()=>authRepo.getBranches();

}