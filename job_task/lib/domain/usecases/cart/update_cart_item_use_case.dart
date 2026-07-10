
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/cart/update_cart_request.dart';
import 'package:job_task/domain/repository/home_page_repo.dart';

@singleton
class UpdateCartItemUseCase {
  final HomePageRepo homePageRepo;
  UpdateCartItemUseCase(this.homePageRepo);
  Future<ApiResult<int>> execute(UpdateCartRequest request) => homePageRepo.updateProductFromCart(request);
}

