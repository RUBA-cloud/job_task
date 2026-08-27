
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/cart/remove_product_in_cart.dart';
import 'package:job_task/data/model/response/cart/cart_entity.dart';
import 'package:job_task/domain/repository/home_page_repo.dart';

@singleton
class RemoveCartItemUseCase {
  final HomePageRepo homePageRepo;
  RemoveCartItemUseCase(this.homePageRepo);
  Future<ApiResult<CartEntity>> execute(RemoveProductFromCartRequest id) => homePageRepo.removeProductFromCard(id);
}

