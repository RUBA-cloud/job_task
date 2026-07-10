
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/cart/add_product_to_cart.dart';
import 'package:job_task/domain/repository/home_page_repo.dart';

@singleton
class AddCartToProductUseCase {
  final HomePageRepo homePageRepo;
  AddCartToProductUseCase(this.homePageRepo);

  Future<ApiResult<int>> execute(AddProductToCartRequest request) => homePageRepo.addProductToCart(request);
}

