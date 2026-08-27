
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/response/remove_fav_entity.dart';
import 'package:job_task/domain/repository/home_page_repo.dart';

@singleton
class RemoveProductFromFavUseCase {
  final HomePageRepo homePageRepo;
  RemoveProductFromFavUseCase(this.homePageRepo);

  Future<ApiResult<RemoveFavEntity>> execute(int favid) => homePageRepo.deleteProductFromFav(favid);
}

