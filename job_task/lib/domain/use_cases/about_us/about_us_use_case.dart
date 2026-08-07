import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/response/about_us_entity.dart';
import 'package:job_task/domain/repository/home_page_drawer_repo.dart';

@singleton
class AboutUsUseCase {

  final HomePageDrawerRepo authRepo;
  AboutUsUseCase(this.authRepo);
  Future<ApiResult<AboutUsEntity>>execute()=>authRepo.aboutUs();

}