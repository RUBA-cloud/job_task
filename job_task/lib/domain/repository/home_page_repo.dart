
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/cart/add_product_to_cart.dart';
import 'package:job_task/data/model/request/cart/remove_product_in_cart.dart';
import 'package:job_task/data/model/request/cart/update_cart_request.dart';
import 'package:job_task/data/model/request/faviorate/add_to_fav_request.dart' show AddToFavRequest;
import 'package:job_task/data/model/response/cart/add_product_to_cart_entity.dart';
import 'package:job_task/data/model/response/cart/cart_entity.dart';
import 'package:job_task/data/model/response/category_entity.dart';
import 'package:job_task/data/model/response/faviorate_entity.dart';
import 'package:job_task/data/model/response/remove_fav_entity.dart';


abstract class HomePageRepo {

  Future<ApiResult<CategoryEntity>> getProducts();
  Future<ApiResult<FaviorateEntity>> addProductToFav(AddToFavRequest favRequest);
  Future<ApiResult<AddProductToCartEntity>> addProductToCart(AddProductToCartRequest favRequest);
  Future<ApiResult<RemoveFavEntity>> deleteProductFromFav(int favId);
  Future<ApiResult<CartEntity>> removeProductFromCard(RemoveProductFromCartRequest removeCartRequest);
  Future<ApiResult<CartEntity>> updateProductQuantity(UpdateCartRequest updateRequest);
  Future<ApiResult<CartEntity>> getCartList();
  Future<ApiResult<FaviorateEntity>> getFavorites();

}