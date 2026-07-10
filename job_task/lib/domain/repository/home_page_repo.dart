
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/cart/add_product_to_cart.dart';
import 'package:job_task/data/model/request/cart/update_cart_request.dart';
import 'package:job_task/data/model/request/faviorate/add_to_fav_request.dart' show AddToFavRequest;
import 'package:job_task/data/model/response/cart_entity.dart';
import 'package:job_task/data/model/response/product_entity.dart';

abstract class HomePageRepo {

  Future<ApiResult<List<ProductEntity>>> getProducts();
  Future<ApiResult<int>>addProductToFav(AddToFavRequest favRequest);
  Future<ApiResult<int>>addProductToCart(AddProductToCartRequest favRequest);
  Future<ApiResult<int>>deleteProductFromFav(int favId);
  Future<ApiResult<int>>updateProductFromCart(UpdateCartRequest cartRequest);
  Future<ApiResult<int>>removeProductFromCard(int favId);
  Future<ApiResult<List<CartEntity>>>getCartList();
  Future<ApiResult<bool>>checkItemAlreadyInCard(int productId);
}