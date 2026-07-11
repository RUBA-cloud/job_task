
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/domain/repository/home_page_repo.dart';

@singleton
class CheckProductInCartUseCase {
  final HomePageRepo homePageRepo;
  CheckProductInCartUseCase(this.homePageRepo);
  Future<ApiResult<bool>> execute(int productId) => homePageRepo.checkItemAlreadyInCard(productId);
}

