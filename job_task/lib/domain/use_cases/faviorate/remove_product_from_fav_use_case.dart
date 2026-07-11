
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/faviorate/add_to_fav_request.dart';
import 'package:job_task/domain/repository/home_page_repo.dart';

@singleton
class RemoveProductFromFavUseCase {
  final HomePageRepo homePageRepo;
  RemoveProductFromFavUseCase(this.homePageRepo);

  Future<ApiResult<int>> execute(int favRequest) => homePageRepo.removeProductFromCard(favRequest);
}

