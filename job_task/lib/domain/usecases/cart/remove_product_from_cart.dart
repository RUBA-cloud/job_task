
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/domain/repository/home_page_repo.dart';

@singleton
class RemoveCartItemUseCase {
  final HomePageRepo homePageRepo;
  RemoveCartItemUseCase(this.homePageRepo);
  Future<ApiResult<int>> execute(int id) => homePageRepo.removeProductFromCard(id);
}

