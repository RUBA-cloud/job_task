import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/core/di/sql_lite_connection.dart';
import 'package:job_task/core/extenstion/dio_exception_exstenstion.dart';
import 'package:job_task/data/api_service/api_service.dart';
import 'package:job_task/data/model/request/cart/add_product_to_cart.dart';
import 'package:job_task/data/model/request/cart/update_cart_request.dart';
import 'package:job_task/data/model/request/faviorate/add_to_fav_request.dart';
import 'package:job_task/data/model/response/cart_entity.dart';
import 'package:job_task/data/model/response/product_entity.dart';
import 'package:job_task/domain/repository/home_page_repo.dart';

@Injectable(as: HomePageRepo)
class HomePageRepoImp implements HomePageRepo {
  final ApiService _apiService;
  final SqlLiteConnection _db; // local store for favorites + cart

  const HomePageRepoImp(this._apiService, this._db);

  @override
  Future<ApiResult<List<ProductEntity>>> getProducts() async {
    try {
      final res = await _apiService.getProducts();
      return Success(data: res);
    } on DioException catch (e) {
      return Failure(
        error: DioExceptionExtension.parseDioError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return Failure(error: e.toString());
    }
  }

  @override
  Future<ApiResult<int>> addProductToFav(AddToFavRequest favRequest) {
    return _db.addFavoriteRequest(favRequest);
  }

  @override
  Future<ApiResult<int>> deleteProductFromFav(int favId) {
    return _db.removeFavorite(favId);
  }

  @override
  Future<ApiResult<int>> removeProductFromCard(int favId) {
    return _db.removeFromCart(favId);
  }

  @override
  Future<ApiResult<int> >addProductToCart(AddProductToCartRequest addRequest) {
    return _db.addToCartRequest(addRequest);
  }

  @override
  Future<ApiResult<int>> updateProductFromCart(UpdateCartRequest cartRequest) {
    return _db.updateCartItem(cartRequest); // was updateCartItem (doesn't exist)
  }

  @override
  Future<ApiResult<List<CartEntity>>> getCartList() async {
    return await _db.getCartItems(); // List<Map<String, Object?>>

  }

  @override
  Future<ApiResult<bool>> checkItemAlreadyInCard(int productId) async{
    return await _db.isInCart(productId); // List<Map<S
  }
}